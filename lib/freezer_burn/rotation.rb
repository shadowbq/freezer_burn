require 'tempfile'

module FreezerBurn
  class Rotation

    attr_reader :collection

    def self.rotate(fridge=FreezerBurn::Settings.fridge)
      rotation = self.new(fridge)
      rotation.rotate
    end

    def initialize(fridge=FreezerBurn::Settings.fridge)
      # Seconds since epoch
      @unixtime = Time.now.utc.to_i
      @interval = 86_400

      # UT END of TODAY(uteot).
      @uteot = (Time.now + @interval).change(hour: 0).to_i

      # UT START of TODAY(utsot).
      @utsot = @uteot - @interval

      @collection = _build_collection(fridge)

      _parser_setting
      return self
    end

    def rotate
      begin
        _rotate_interval

        # Fall back interval.
        @uteot -= @interval
        @utsot -= @interval

        # limit selecting to only one year
        @collection = [] if @unixtime - Settings.max_scan_time_in_sec > @uteot

      end while !@collection.empty?
    end

    #private
    # Stub
    def _parser_setting
      raise FactoryError, "method not defined by Parent object"
    end

    # Stub
    def _build_collection(dir)
      raise FactoryError, "method not defined by Parent object"
    end

    # Stub
    def _get_file_epoch_cxtracker(filename)
      raise FactoryError, "method not defined by Parent object"
    end

    def _rotate_interval
      puts "Searching #{@utsot} -> #{@uteot}: #{@collection.size} files" if Settings.verbose
      daylist = []
      @collection.each do |file|
        daylist.push(file) if (@utsot..@uteot) === file[:file_epoch]
      end
      unless daylist.empty?
        puts "#{daylist.first[:filename]} .. #{daylist.last[:filename]}" if Settings.verbose
        @collection -= daylist

        # compress tarball daylist, write filename with earliest.lastest.gz.tar epoch time.
        # best way to handle thousands of files is with gnu-tar (tar must support -T flag)
        Tempfile.open('tar-ball-listing') do |f|
          daylist.each { |fileref| f.puts(fileref[:filename]) }
          f.close
          # write filenames to a filelist.
          cmd_string = "#{Settings.gnu_tar_command} -T #{f.path} --append -z #{Settings.remove_files}-f #{Settings.freezer}/#{Settings.prefix}.#{daylist.first[:file_epoch]}-#{daylist.last[:file_epoch]}.tar.gz > /dev/null 2>&1"
          puts cmd_string if Settings.verbose
          `#{cmd_string}` unless Settings.dryrun
        end

      end # unless

    end # def

  end
end
