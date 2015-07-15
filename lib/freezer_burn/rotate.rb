require 'tempfile'

module FreezerBurn

    class Rotation

        def initialize
            @epoch = Time.now.utc.to_i
            # EPOCH END of TODAY(EEoT).
            @eeot = (Time.now + 86400).change(hour:0).to_i
            # EPOCH START of TODAY(ESoT).
            @esot = @eeot - 86400
            @collection = build_collection(FreezerBurn::Fridge)
            rotate
        end

        private
        
        def build_collection(dir)
            @dirglob = Dir.glob(dir)
            collection = []

            @dirglob.each do |filename|
                collection << {:filename => filename, :file_epoch => get_file_epoch(filename)}
            end

            @dirglob = nil

            # remove from collection elements with no file_epoch k/v
            return collection.collect{|e| e if e[:file_epoch] != "" }.compact
        end

        #if @esot == 1429833600
        #    binding.pry
        #end
        # stats.bge1.1429901797

        def get_file_epoch(filename)
            begin
                file_epoch = filename.split('.')[2]
                # should safely cast
                file_epoch = Integer(file_epoch)
                # ArgumentError: invalid value for Integer: "nights"
                return file_epoch
            rescue
                return ""
            end
        end

        def rotate
            begin
                puts "Searching #{@esot} -> #{@eeot}: #{@collection.size} files" if FreezerBurn::VERBOSE
                daylist = []
                @collection.each do |file|
                    daylist.push(file) if (@esot..@eeot) === file[:file_epoch]
                end

                unless daylist.empty?
                  puts "#{daylist.first[:filename]} .. #{daylist.last[:filename]}" if FreezerBurn::VERBOSE
                  @collection = @collection - daylist

                  # compress tarball daylist, write filename with earliest.lastest.gz.tar epoch time.
                  # best way to handle thousands of files is with gnu-tar (tar must support -T flag)
                  Tempfile.open('tar-ball-listing') do |f|
                      daylist.each {|fileref| f.puts(fileref[:filename]) }
                      f.close
                      # write filenames to a filelist.

                      puts "#{FreezerBurn::Gnu_tar_command} -T #{f.path} --append -z #{FreezerBurn::Remove_files}-f #{FreezerBurn::Freezer}/#{FreezerBurn::Prefix}.#{daylist.first[:file_epoch]}-#{daylist.last[:file_epoch]}.tar.gz > /dev/null 2>&1" if FreezerBurn::VERBOSE
                      `#{FreezerBurn::Gnu_tar_command} -T #{f.path} --append -z #{FreezerBurn::Remove_files}-f #{FreezerBurn::Freezer}/#{FreezerBurn::Prefix}.#{daylist.first[:file_epoch]}-#{daylist.last[:file_epoch]}.tar.gz > /dev/null 2>&1`
                  end

                end

                # Fall back one day.
                @eeot = @eeot - 86400
                @esot = @esot - 86400

                # limit selecting to only one year
                if @epoch - FreezerBurn::Max_scan_time_in_sec > @eeot
                    @collection = []
                end

            end while not @collection.empty?
        end

    end

end
