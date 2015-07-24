require 'pry'
# binding.pry
require 'test_helper'
require 'minitest/spec'

describe "rotation" do

  before do
    FreezerBurn::Settings.reset!
    FreezerBurn::Settings.fridge = './test/data/stats.*'
    FreezerBurn::Settings.freezer = './test/data/freezer'
  end

  describe 'when calling an rotation job' do
    it 'should return a roation job object' do
      job = FreezerBurn::Cxtracker.new
      job.must_be_instance_of FreezerBurn::Cxtracker
    end

    it 'should respond with a collection of files in fridge' do
      job = FreezerBurn::Cxtracker.new
      job.collection.must_be_instance_of Array
      job.collection.must_equal [{:filename=>"./test/data/stats.bge1.1429901799", :file_epoch=>1429901799}, {:filename=>"./test/data/stats.bge1.1429901795", :file_epoch=>1429901795}, {:filename=>"./test/data/stats.bge1.1429901797", :file_epoch=>1429901797}]
    end

  end

end
