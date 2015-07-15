class Time
    def change(options)
      new_year  = options.fetch(:year, year)
      new_month = options.fetch(:month, month)
      new_day   = options.fetch(:day, day)
      new_hour  = options.fetch(:hour, hour)
      new_min   = options.fetch(:min, options[:hour] ? 0 : min)
      new_sec   = options.fetch(:sec, (options[:hour] || options[:min]) ? 0 : sec)

      if new_nsec = options[:nsec]
        raise ArgumentError, "Can't change both :nsec and :usec at the same time: #{options.inspect}" if options[:usec]
        new_usec = Rational(new_nsec, 1000)
      else
        new_usec  = options.fetch(:usec, (options[:hour] || options[:min] || options[:sec]) ? 0 : Rational(nsec, 1000))
      end

      if utc?
        ::Time.utc(new_year, new_month, new_day, new_hour, new_min, new_sec, new_usec)
      elsif zone
        ::Time.local(new_year, new_month, new_day, new_hour, new_min, new_sec, new_usec)
      else
        raise ArgumentError, 'argument out of range' if new_usec >= 1000000
        ::Time.new(new_year, new_month, new_day, new_hour, new_min, new_sec + (new_usec.to_r / 1000000), utc_offset)
      end
    end

    def seconds_since_midnight
        to_i - change(:hour => 0).to_i + (usec / 1.0e+6)
    end
end
