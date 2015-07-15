require 'tempfile'

module FreezerBurn

    class Rotation

        def self.rotate(fridge)
            self.new(fridge)
        end

        def initialize(fridge)
            # Seconds since epoch
            @epoch = Time.now.utc.to_i

            # EPOCH END of TODAY(EEoT).
            @eeot = (Time.now + 86400).change(hour:0).to_i

            # EPOCH START of TODAY(ESoT).
            @esot = @eeot - 86400

            @collection = build_collection(fridge)
            rotate
        end

        private

        def build_collection(dir)
            @dirglob = Dir.glob(dir)
            collection = []

            @dirglob.each do |filename|
                collection << {:filename => filename, :file_epoch => _get_file_epoch_cxtracker(filename)}
            end

            @dirglob = nil

            # remove from collection elements with no file_epoch k/v
            return collection.collect{|e| e if e[:file_epoch] != "" }.compact
        end


        # stats.bge1.1429901797
        def _get_file_epoch_cxtracker(filename)
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
                puts "Searching #{@esot} -> #{@eeot}: #{@collection.size} files" if Settings.verbose
                daylist = []
                @collection.each do |file|
                    daylist.push(file) if (@esot..@eeot) === file[:file_epoch]
                end

                unless daylist.empty?
                  puts "#{daylist.first[:filename]} .. #{daylist.last[:filename]}" if Settings.verbose
                  @collection = @collection - daylist

                  # compress tarball daylist, write filename with earliest.lastest.gz.tar epoch time.
                  # best way to handle thousands of files is with gnu-tar (tar must support -T flag)
                  Tempfile.open('tar-ball-listing') do |f|
                      daylist.each {|fileref| f.puts(fileref[:filename]) }
                      f.close
                      # write filenames to a filelist.

                      puts "#{Settings.gnu_tar_command} -T #{f.path} --append -z #{Settings.remove_files}-f #{Settings.freezer}/#{Settings.prefix}.#{daylist.first[:file_epoch]}-#{daylist.last[:file_epoch]}.tar.gz > /dev/null 2>&1" if Settings.verbose
                      `#{Settings.gnu_tar_command} -T #{f.path} --append -z #{Settings.remove_files}-f #{Settings.freezer}/#{Settings.prefix}.#{daylist.first[:file_epoch]}-#{daylist.last[:file_epoch]}.tar.gz > /dev/null 2>&1` unless Settings.dryrun
                  end

                end

                # Fall back one day.
                @eeot = @eeot - 86400
                @esot = @esot - 86400

                # limit selecting to only one year
                if @epoch - Settings.max_scan_time_in_sec > @eeot
                    @collection = []
                end

            end while not @collection.empty?
        end

    end

end
