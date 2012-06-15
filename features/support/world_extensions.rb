def without_timestamping_of(*klasses)
  if block_given?
    klasses.delete_if { |klass| !klass.record_timestamps }
    klasses.each { |klass| klass.record_timestamps = false }
    begin
      yield
    ensure
      klasses.each { |klass| klass.record_timestamps = true }
    end
  end
end