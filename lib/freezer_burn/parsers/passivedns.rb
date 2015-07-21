module FreezerBurn
  class Passivedns < Rotation

    def _parser_setting
      FreezerBurn::Settings.prefix 'passivedns'
      FreezerBurn::Settings.fridge '/var/db/yard/stats.*'
    end

    def _build_collection(dir)
      @dirglob = Dir.glob(dir)
      collection = []

      @dirglob.each do |filename|
        collection << { filename: filename, file_epoch: _get_file_epoch(filename) }
      end

      @dirglob = nil

      # remove from collection elements with no file_epoch k/v
      collection.collect { |e| e if e[:file_epoch] != '' }.compact
    end

    # ./test/data/stats.bge1.1429901797
    # stats.bge1.1429901798
    def _get_file_epoch(filename)
      file_epoch = File.basename(filename).split('.')[2]
      # should safely cast
      file_epoch = Integer(file_epoch)
      # ArgumentError: invalid value for Integer: "nights"
      return file_epoch
    rescue
      return ''
    end

  end
end
