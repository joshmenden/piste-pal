module PistePal
  module DataServices
    class MaxSpeedAndAltitude
      def self.call(trackpoints:)
        new(trackpoints).call
      end

      def call
        max_speed_and_altitude
      end

      private

      def initialize(trackpoints)
        @trackpoints = trackpoints
      end

      def max_speed_and_altitude
        max_speed = 0
        max_alt = 0
        @trackpoints.each do |trackpoint|
          max_speed = trackpoint.speed if trackpoint.speed > max_speed
          max_alt = trackpoint.elevation if trackpoint.elevation > max_alt
        end
        [max_speed, max_alt]
      end
    end
  end
end

