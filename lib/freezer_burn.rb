#STDLIBS
require 'rubygems'

module FreezerBurn
    $:.unshift(File.dirname(__FILE__))

    MAX_FILEPATH_BUF = 1024
    UINT32_t = 4

    require "ext/time"
    require "freezer_burn/main"
    require "freezer_burn/version"

end
