# STDLIBS
require 'rubygems'

module FreezerBurn
  $LOAD_PATH.unshift(File.dirname(__FILE__))

  MAX_FILEPATH_BUF = 1024
  UINT32_t = 4

  require 'ext/time'
  require 'freezer_burn/main'
  require 'freezer_burn/version'
  require 'freezer_burn/rotation'
  require 'freezer_burn/parsers/cxtracker'
  require 'freezer_burn/parsers/passivedns'
end
