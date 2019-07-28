require "vincenty"
module PistePal
  class DayPass
    attr_accessor :resort, :date, :trackpoints, :maximum_speed, :peak_altitude, :vertical

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
      # we need to separate out runs from lift rides
      @distance = PistePal::DataServices::Distance.call(trackpoints: @trackpoints)
      byebug
      puts "Success!"
    end

  end
end
