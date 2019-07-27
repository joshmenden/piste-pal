require_relative 'trackpoint'
require_relative 'data_services/gpx_doc'
require_relative 'data_services/extract_trackpoints_from_file'
require_relative 'data_services/extract_date_and_resort'
require 'byebug'

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
