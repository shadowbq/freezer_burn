require 'rubygems'
require 'bundler/setup'

require 'simplecov'
SimpleCov.start do
  add_filter '/test/'
  add_group 'Bin', '/lib/cli'
  add_group 'Lib', '/lib'
end

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

gem "minitest"
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/spec'

# :: Scaffold for CodeClimate
# require "codeclimate-test-reporter"
# CodeClimate::TestReporter.start

#require File.join(File.dirname(__FILE__), '..', 'freezer_burn')
require File.join(File.dirname(__FILE__), '..', 'lib', 'freezer_burn')
