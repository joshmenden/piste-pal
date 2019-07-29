module PistePal
  module DataServices
    class Vertical
      def self.call(trackpoints:)
        new(trackpoints: trackpoints).call
      end

      def call
        vertical = 0
        @trackpoints.each do |trackpoints|
          vertical += (trackpoints.first.elevation - trackpoints.last.elevation)
        end
        vertical
      end

      private

      def initialize(trackpoints:)
        @trackpoints = trackpoints
      end
    end
  end
end



