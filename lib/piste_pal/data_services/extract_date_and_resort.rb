require 'open-uri'
require 'nokogiri'
require_relative 'gpx_doc'
require_relative '../trackpoint'
module PistePal
  module DataServices
    class ExtractDateAndResort
      def self.call
        new().call
      end

      def call
        name_node = @doc.xpath("//xmlns:name")
        @date, @resort_name = name_node.children.first.text.strip.split(" - ")
        @date = Time.parse(@date)
        return [@date, @resort_name]
      end

      private

      def initialize
        @doc = PistePal::DataServices::GpxDoc.instance.doc
      end
    end
  end
end

