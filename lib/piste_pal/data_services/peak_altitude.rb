module PistePal
  module DataServices
    class PeakAltitude
      def self.call(trackpoints:)
        new(trackpoints).call
      end

      def call
        determine_maximum_speed
      end

      private

      def initialize(trackpoints)
        @trackpoints = trackpoints
      end

      def determine_maximum_speed
        max_speed = 0
        @trackpoints.each do |trackpoint|
          max_speed = trackpoint.speed if trackpoint.speed > max_speed
        end
        max_speed
      end
    end
  end
end
