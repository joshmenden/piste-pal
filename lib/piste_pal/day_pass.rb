require "vincenty"
module PistePal
  class DayPass
    attr_accessor :resort, :date, :trackpoints, :maximum_speed, :peak_altitude, :vertical, :distance

    def self.purchase file_source
      new(file_source: file_source)
    end

    def maximum_speed(system = "imperial")
      return (@maximum_speed * 1.60934) if system == "metric"
      return @maximum_speed if system == "imperial"
    end

    def peak_altitude(system = "imperial")
      return @peak_altitude if system == "metric"
      return (@peak_altitude * 3.28084) if system == "imperial"
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
      puts "Success!"
    end

  end
end
