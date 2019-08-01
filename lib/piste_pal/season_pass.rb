module PistePal
  class SeasonPass
    attr_accessor :days, :resorts, :runs, :vertical, :distance

    def self.purchase files
      new(files: files)
    end

    def days(timestamp_only: false)
      return @days if !timestamp_only
      return @days.map {|day| day.date }
    end

    private

    def initialize(files:)
      @days = []
      files.each do |f|
        @days.push(PistePal::DayPass.purchase(f))
      end

      @resorts = @days.map {|day| day.resort }.uniq
      @runs = @days.map {|day| day.runs.count }.reduce(0, :+)
      @vertical = {
        :value => @days.map {|day| day.vertical[:value] }.reduce(0, :+),
        :unit => @days.first.vertical[:unit]
      }
      @distance = {
        :value => @days.map {|day| day.distance[:value] }.reduce(0, :+),
        :unit => @days.first.distance[:unit]
      }
    end
  end
end

