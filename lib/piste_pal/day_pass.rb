require "vincenty"
module PistePal
  class DayPass
    attr_accessor :resort, :date, :trackpoints, :maximum_speed, :peak_altitude, :vertical, :distance, :tallest_run, :longest_run, :runs, :lifts

    def self.purchase file_source
      new(file_source: file_source)
    end

    # convert mp/h to km/h
    def maximum_speed(system = "imperial")
      return (@maximum_speed * 1.60934) if system == "metric"
      return @maximum_speed if system == "imperial"
    end

    # convert meters to feet
    def peak_altitude(system = "imperial")
      return @peak_altitude if system == "metric"
      return (@peak_altitude * 3.28084) if system == "imperial"
    end

    # convert meters to km / miles
    def distance(system = "imperial")
      return @distance / 1000 if system == "metric"
      return @distance / 1609.344 if system == "imperial"
    end

    # convert meters to feet
    def vertical(system = "imperial")
      return @vertical if system == "metric"
      return @vertical * 3.28084 if system == "imperial"
    end

    # convert meters to feet
    def tallest_run(system = "imperial")
      return @tallest_run if system == "metric"
      return @tallest_run * 3.28084 if system == "imperial"
    end

    # convert meters to miles
    def longest_run(system = "imperial")
      return @longest_run if system == "metric"
      return @longest_run / 1609.344 if system == "imperial"
    end

    private

    def initialize(file_source:)
      PistePal::DataServices::GpxDoc.set_instance(file_source)
      @trackpoints = PistePal::DataServices::Trackpoints.call
      @date, @resort = PistePal::DataServices::DateAndResort.call
      @maximum_speed, @peak_altitude = PistePal::DataServices::MaxSpeedAndAltitude.call(trackpoints: @trackpoints)
      @runs, @lifts = PistePal::DataServices::RunsAndLifts.call(trackpoints: @trackpoints)
      @distance = PistePal::DataServices::Distance.call(trackpoints: @runs)
      @vertical = PistePal::DataServices::Vertical.call(trackpoints: @runs)
      @tallest_run, @longest_run = PistePal::DataServices::TallestAndLongestRun.call(runs: @runs)

    end

  end
end
