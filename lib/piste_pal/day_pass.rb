require 'open-uri'
require 'nokogiri'
require 'daru'
require_relative 'trackpoint'
require 'byebug'


module PistePal
  class DayPass

    attr_accessor :resort_name, :date, :trackpoints

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

        test_array = []
        trackpoints = doc.xpath("//xmlns:trkpt")
        trackpoints.each do |tp|
          params = Hash.new
          params[:lat] = tp.xpath('@lat').to_s.to_f
          params[:lon] = tp.xpath('@lon').to_s.to_f
          tp.children.each do |child|
            params[:elevation] = child.text.strip.to_f if child.name == "ele"
            params[:time] = child.text.strip if child.name == "time"
            params[:hdop] = child.text.strip.to_i if child.name == "hdop"
            params[:vdop] = child.text.strip.to_i if child.name == "vdop"
          end
          extensions = tp.children.search("extensions").first
          extensions.children.each do |child|
            params[:speed] = child.attributes["speed"].value.to_s.to_f if child.name == "gps" && !child.attributes["speed"].nil?
          end
          test_array.push(params)
        end
        byebug
        puts "Success parse"
      end
    end
  end
end
