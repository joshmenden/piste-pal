require 'open-uri'
require 'nokogiri'
require 'daru'
require_relative 'trackpoint'
require 'byebug'


module PistePal
  class DayPass

    attr_accessor :resort_name, :date

    def self.purchase file_source
      new(file_source: file_source)
    end

    private

    def initialize(file_source:)
      @file_source = file_source
      parse_data
    end

    def parse_data
      if @file_source.include?("http")
      else
        doc = Nokogiri::XML(File.open(@file_source)) do |config|
          config.strict.noblanks
        end

        # Determine date and resort name from file
        name_node = doc.xpath("//xmlns:name")
        @date, @resort_name = name_node.children.first.text.strip.split(" - ")
        @date = Time.parse(@date)

        trackpoints = doc.xpath("//xmlns:trkpt")
        byebug
        puts "Success parse"
      end
    end
  end
end
