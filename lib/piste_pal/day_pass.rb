module PistePal
  class DayPass
    attr_accessor :resort, :date, :trackpoints

    def self.purchase file_source
      new(file_source: file_source)
    end

    private

    def initialize(file_source:)
      PistePal::DataServices::GpxDoc.set_instance(file_source)
      @trackpoints = PistePal::DataServices::ExtractTrackpointsFromFile.call
      @date, @resort = PistePal::DataServices::ExtractDateAndResort.call
    end
  end
end
