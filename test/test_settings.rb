require 'test_helper'
require 'minitest/spec'

describe FreezerBurn::Settings do

  before do
    FreezerBurn::Settings.reset!
    FreezerBurn::Settings.freezer = './test/data/freezer'
  end

  describe 'when calling an APP Setting' do
    it 'should respond with defaults' do
      FreezerBurn::Settings.fridge.must_equal '/var/db/fridge/*.log'
    end

    it 'should list its attributes' do
      FreezerBurn::Settings.list.must_equal [:verbose, :dryrun, :fridge, :freezer, :gnu_tar_command, :remove_files, :prefix, :max_scan_time_in_sec]
    end

    it 'should convert to a hash with new test settings' do
      target_hash = {:verbose=>nil, :dryrun=>nil, :fridge=>"/var/db/fridge/*.log", :freezer=>"./test/data/freezer", :gnu_tar_command=>"gtar", :remove_files=>"--remove-files ", :prefix=>"cxtracker", :max_scan_time_in_sec=>31536000}
      FreezerBurn::Settings.to_h.must_equal target_hash
    end

  end

end
