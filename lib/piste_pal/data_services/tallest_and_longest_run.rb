module PistePal
  module DataServices
    class TallestAndLongestRun
      def self.call(runs:)
        new(runs: runs).call
      end

      def call
        tallest = 0
        longest = 0
        @runs.each do |run|
          vertical = run.first.elevation - run.last.elevation
          distance = PistePal::DataServices::Distance.call(trackpoints: run)
          
          tallest = vertical if vertical > tallest
          longest = distance if distance > longest
        end

        [tallest, longest]
      end

      private

      def initialize(runs:)
        @runs = runs
      end
    end
  end
end

