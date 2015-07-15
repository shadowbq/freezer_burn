require 'rubygems'
require "docopt"
require 'freezer_burn'

module FreezerBurn

    class CLI

        def self.invoke
            self.new
        end

        def initialize

doc = <<DOCOPT
Example of program with many options using docopt.
Usage:
  ./bin/freezer_selector [-vd] [--run]
  ./bin/freezer_selector -h | --help
  ./bin/freezer_selector --version

Options:
  --run                explicitly run the freezer_selector
  -h --help            show this help message and exit
  --version            show version and exit
  -d --dry-run         simulate without moving files
  -v --verbose         print status messages
DOCOPT

            options = {}
            begin
                options = Docopt::docopt(doc)
            rescue Docopt::Exit => e
                puts e.message
                exit 1
            end

            if options['--version']
                puts FreezerBurn::VERSION
                exit 0
            end

            if options['--verbose']
                FreezerBurn::Settings.verbose = true
            else
                FreezerBurn::Settings.verbose = false
            end

            if options['--dry-run']
                FreezerBurn::Settings.dryrun = true
            end

            FreezerBurn::Rotation.rotate(FreezerBurn::Settings.fridge}



        end # def

    end # class
end # module
