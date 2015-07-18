require 'test_helper'
require 'minitest/spec'

describe FreezerBurn::Settings do

  before do
    FreezerBurn::Settings.reset!
  end

  describe 'when calling an APP Setting' do
    it 'should respond with defaults' do
      FreezerBurn::Settings.fridge.must_equal '/var/db/yard/stats.*'
    end

    it 'should list its attributes' do
      FreezerBurn::Settings.list.must_equal [:verbose, :dryrun, :fridge, :freezer, :gnu_tar_command, :remove_files, :prefix, :max_scan_time_in_sec]
    end

  end

end
