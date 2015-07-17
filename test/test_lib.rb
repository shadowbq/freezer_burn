require 'minitest/spec'

describe String do
  before do
    @meme = ''
    @meme = 'foobar'
  end

  describe 'when looking for foo' do
    it 'should respond positively' do
      @meme.include?('foo').must_equal true
    end
  end

  describe 'when asked about bar possibilities in front submatch' do
    it 'it will not match' do
      @meme[0..2].wont_match /^bar/i
    end
  end
end
