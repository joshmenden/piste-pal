module PistePal
  class DayPass
    attr_accessor :resort, :date, :trackpoints, :maximum_speed, :peak_altitude

    def self.purchase file_source
      new(file_source: file_source)
    end

    private

    def initialize(file_source:)
      PistePal::DataServices::GpxDoc.set_instance(file_source)
      @trackpoints = PistePal::DataServices::Trackpoints.call
      @date, @resort = PistePal::DataServices::DateAndResort.call
      @maximum_speed = PistePal::DataServices::MaximumSpeed.call(trackpoints: @trackpoints)
      @peak_altitude = PistePal::DataServices::PeakAltitude.call(trackpoint: @trackpoints)
      puts "Success!"
    end
  end
end
