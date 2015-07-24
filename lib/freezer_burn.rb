# STDLIBS
require 'rubygems'

module FreezerBurn
  $LOAD_PATH.unshift(File.dirname(__FILE__))

  class ClassError < StandardError; end
  class UnknownParser < StandardError; end

  MAX_FILEPATH_BUF = 1024
  UINT32_t = 4

  require 'ext/object'
  require 'ext/time'
  require 'freezer_burn/settings'
  require 'freezer_burn/version'
  require 'freezer_burn/rotation'
  require 'freezer_burn/parsers/cxtracker'
  require 'freezer_burn/parsers/passivedns'
end
