require 'rubygems'
require 'docopt'
require 'freezer_burn'

module FreezerBurn
  class CLI
    def self.invoke
      new
    end

    def initialize
      doc = <<DOCOPT
Example of program with many options using docopt.
Usage:
  ./bin/freezer_selector [-vdk] [--version] [-f <fridge>] [-F <freezer>]
  ./bin/freezer_selector -h | --help

Options:
  -f <fridge>          look for logs here
  -F <freezer>         store file here
  -k --keep-files      keep original files in the fridge
  -h --help            show this help message and exit
  --version            show version and exit
  -d --dry-run         simulate without moving files
  -v --verbose         print status messages

DOCOPT

      options = {}
      begin
        options = Docopt.docopt(doc)
        rescue Docopt::Exit => e
          puts e.message
          exit 1
      end

      if options['--verbose']
        FreezerBurn::Settings.verbose = true
      else
        FreezerBurn::Settings.verbose = false
      end

      FreezerBurn::Settings.dryrun = true if options['--dry-run']

      FreezerBurn::Settings.remove_files = '' if options['--keep-files']

      FreezerBurn::Settings.fridge = options['-f'] if options['-f']

      FreezerBurn::Settings.freezer = options['-F'] if options['-F']

      if options['--version']
        puts 'version => ' + FreezerBurn::VERSION.to_s
        if FreezerBurn::Settings.verbose
          FreezerBurn::Settings.list.each do |toggle|
            puts "#{toggle} => #{FreezerBurn::Settings.send(toggle)}"
          end
        end
        exit 0
      end

      FreezerBurn::Rotation.rotate(FreezerBurn::Settings.fridge)
    end # def
  end # class
end # module
