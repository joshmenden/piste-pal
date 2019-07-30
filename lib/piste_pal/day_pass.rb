module PistePal
  class DayPass
    attr_accessor :resort, :date, :trackpoints, :maximum_speed, :peak_altitude, :vertical, :distance, :tallest_run, :longest_run, :runs, :lifts

    def self.purchase file_content
      new(file_content: file_content)
    end

    # convert mp/h to km/h
    def maximum_speed(system = "imperial")
      if system == "metric"
        value = (@maximum_speed * 1.60934)
        unit = "kmh"
      elsif system == "imperial"
        value = @maximum_speed
        unit = "mph"
      end

      { :value => value, :unit => unit }
    end

    # convert meters to feet
    def peak_altitude(system = "imperial")
      if system == "metric"
        value = @peak_altitude
        unit = "meters"
      elsif system == "imperial"
        value = @peak_altitude * 3.28084
        unit = "feet"
      end

      { :value => value, :unit => unit }
    end

    # convert meters to km / miles
    def distance(system = "imperial")
      if system == "metric"
        value = @distance / 1000
        unit = "kilometers"
      elsif system == "imperial"
        value = @peak_altitude / 1609.344
        unit = "miles"
      end

      { :value => value, :unit => unit }
    end

    # convert meters to feet
    def vertical(system = "imperial")
      if system == "metric"
        value = @vertical
        unit = "meters"
      elsif system == "imperial"
        value = @vertical * 3.28084
        unit = "feet"
      end

      { :value => value, :unit => unit }
    end

    # convert meters to feet
    def tallest_run(system = "imperial")
      if system == "metric"
        value = @tallest_run
        unit = "meters"
      elsif system == "imperial"
        value = @tallest_run * 3.28084
        unit = "feet"
      end

      { :value => value, :unit => unit }
    end

    # convert meters to miles
    def longest_run(system = "imperial")
      if system == "metric"
        value = @longest_run / 1000
        unit = "kilometers"
      elsif system == "imperial"
        value = @longest_run / 1609.344
        unit = "miles"
      end

      { :value => value, :unit => unit }
    end

    private

    def initialize(file_content:)
      PistePal::DataServices::GpxDoc.set_instance(file_content)
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
