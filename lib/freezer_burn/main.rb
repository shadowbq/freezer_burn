module FreezerBurn

    class CustomError < StandardError; end

    module Defaults
      Raw = false # FreezerBurn::Defaults::Raw
      VERBOSE = false
      Fridge = '/var/db/yard/stats.*'
      Freezer = '/var/log/freezer'
      Gnu_tar_command ='gtar' # gtar on freebsd / tar on everything else
      Remove_files = '--remove-files '
      Prefix = 'cxtracker'
      Max_scan_time_in_sec = 31536000 # One Year
    end



end
