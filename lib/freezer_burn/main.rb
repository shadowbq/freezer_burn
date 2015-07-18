module FreezerBurn
  class CustomError < StandardError; end

  module Settings
    extend self

    @@registered_settings = []

    # Appdata provides a basic single-method DSL with .parameter method
    # being used to define a set of available settings.
    # This method takes one or more symbols, with each one being
    # a name of the configuration option.
    def parameter(*names)
      names.each do |name|
        attr_accessor name

        @@registered_settings.push(name)

        # For each given symbol we generate accessor method that sets option's
        # value being called with an argument, or returns option's current value
        # when called without arguments
        define_method name do |*values|
          value = values.first
          value ? send("#{name}=", value) : instance_variable_get("@#{name}")
        end
      end
    end

    # And we define a wrapper for the configuration block, that we'll use to set up
    # our set of options
    def config(&block)
      instance_eval &block
    end

    # list available settings
    def self.list
      @@registered_settings
    end

    def self.reset!
      self.config do
        verbose false
        dryrun false
        fridge '/var/db/yard/stats.*'
        freezer '/var/log/freezer'
        gnu_tar_command 'gtar'
        remove_files '--remove-files '
        prefix 'cxtracker'
        max_scan_time_in_sec 31_536_000
      end
    end
  end

  # [1] pry(#<FreezerBurn::CLI>)> Settings.list
  # => [:verbose, :fridge, :freezer, :gnu_tar_command, :remove_files, :prefix, :max_scan_time_in_sec]

  Settings.config do
    parameter :verbose, :dryrun
    parameter :fridge, :freezer
    parameter :gnu_tar_command
    parameter :remove_files
    parameter :prefix
    parameter :max_scan_time_in_sec
  end

  Settings.reset!
end
