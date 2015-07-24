require 'test_helper'
require 'minitest/spec'

describe "rotation" do

  before do
    FreezerBurn::Settings.reset!
  end

  describe 'when calling the stub' do
    it 'should raise a ClassError' do
      proc { FreezerBurn::Rotation.new }.must_raise FreezerBurn::ClassError
    end
  end

end
