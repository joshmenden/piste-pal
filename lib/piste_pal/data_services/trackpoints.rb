require 'nokogiri'
module PistePal
  module DataServices
    class Trackpoints
      def self.call
        new().call
      end

      def call
        extract_trackpoints
        @trackpoints
      end

      private

      def initialize
        @doc = PistePal::DataServices::GpxDoc.instance.doc
        @trackpoints = []
      end

      def extract_trackpoints
        trackpoints = @doc.xpath("//xmlns:trkpt")
        trackpoints.each do |tp|
          @trackpoints.push(PistePal::Trackpoint.new(**extract_params_from_trackpoint_node(tp)))
        end
      end

      def extract_params_from_trackpoint_node trackpoint
        params = Hash.new
        params[:lat] = trackpoint.xpath('@lat').to_s.to_f
        params[:lon] = trackpoint.xpath('@lon').to_s.to_f
        trackpoint.children.each do |child|
          params[:elevation] = child.text.strip.to_f if child.name == "ele"
          params[:time] = child.text.strip if child.name == "time"
          params[:hdop] = child.text.strip.to_i if child.name == "hdop"
          params[:vdop] = child.text.strip.to_i if child.name == "vdop"
        end
        extensions = trackpoint.children.search("extensions").first
        extensions.children.each do |child|
          params[:speed] = child.attributes["speed"].value.to_s.to_f if child.name == "gps" && !child.attributes["speed"].nil?
        end
        return params
      end
    end
  end
end
