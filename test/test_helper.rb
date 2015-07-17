require 'rubygems'
require 'bundler/setup'

require 'simplecov'
SimpleCov.start do
  add_filter '/test/'
  add_group 'Bin', '/lib/cli'
  add_group 'Lib', '/lib'
end

require 'minitest/autorun'
require 'minitest/colorize'
require 'minitest/spec'

require File.join(File.dirname(__FILE__), '..', 'lib', 'freezer_burn', 'cli')
require File.join(File.dirname(__FILE__), '..', 'lib', 'freezer_burn')
