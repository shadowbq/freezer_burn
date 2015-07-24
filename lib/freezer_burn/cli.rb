require 'rubygems'
require 'docopt'
require 'freezer_burn'

module FreezerBurn
  class CLI
    def self.invoke
      new
    end

    def initialize

      @parsers = [:cxtracker, :passivedns]

      doc = <<DOCOPT
Rough management of compressed log files.

Usage:
DOCOPT

      @parsers.each do |parser|
        doc += "freezer_burn #{parser} [-vdk] [--version] [-f <fridge>] [-F <freezer>] \n"
      end

doc_part2 = <<DOCOPT

  freezer_burn -h | --help

Options:
  -f <fridge>          look for logs here
  -F <freezer>         store file here
  -k --keep-files      keep original files in the fridge
  -h --help            show this help message and exit
  --version            show version and exit
  -d --dry-run         simulate without moving files
  -v --verbose         print status messages

DOCOPT

      @options = {}
      begin
        @options = Docopt.docopt(doc+doc_part2)
        rescue Docopt::Exit => e
          puts e.message
          exit 1
      end

      # Boolean switch
      FreezerBurn::Settings.verbose = @options['--verbose'] ? true : false
      FreezerBurn::Settings.dryrun = @options['--dry-run'] ? true : false

      # Maintain defaults
      FreezerBurn::Settings.remove_files = '' if @options['--keep-files']
      FreezerBurn::Settings.fridge = @options['-f'] if @options['-f']
      FreezerBurn::Settings.freezer = @options['-F'] if @options['-F']

      if @options['--version']
        _version
        exit 0
      end

      _meta_parser("rotate")

    end # def

    private

    def _version
      puts 'version => ' + FreezerBurn::VERSION.to_s
      if FreezerBurn::Settings.verbose
        _meta_parser("update_settings!")
        FreezerBurn::Settings.print
      end
    end

    def _meta_parser(cmd)
      @parsers.each do |el|
        el = el.to_s
        klass = "FreezerBurn::" + el.capitalize
        if @options[el]
          Object.const_get19(klass).send(cmd)
          break # jump out of each
        end
      end
    end


  end # class
end # module
