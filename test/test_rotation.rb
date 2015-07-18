# require 'pry'
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
      job = FreezerBurn::Rotation.new
      job.must_be_instance_of FreezerBurn::Rotation
    end

    it 'should respond with a collection of files in fridge' do
      job = FreezerBurn::Rotation.new
      job.collection.must_be_instance_of Array
      job.collection.size.must_equal 3
    end

  end

end
