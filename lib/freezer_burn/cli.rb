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
  ./bin/freezer_selector [-hv ]
  ./bin/freezer_selector --version

Options:
  -h --help            show this help message and exit
  --version            show version and exit
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

        end # def

    end # class
end # module

=begin
begin
      finder = Barnyard2::Waldo::Where.new(options[:bookmark])
      finder.utc = options[:utc]
      puts finder
  rescue Barnyard2::Waldo::WaldoFilePermissionsError
      abort "Waldo File Read Perrmission Error, check permissions on the bookmark file."
  rescue Barnyard2::Waldo::WaldoFileError
      abort "Waldo File Error, file may not exist."
  end
=end
