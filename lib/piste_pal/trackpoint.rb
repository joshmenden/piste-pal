module PistePal
  class Trackpoint
    attr_accessor :lat, :lon, :elevation, :time, :hdop, :vdop, :speed

    def initialize(lat: nil, lon: nil, elevation: nil, time: nil, hdop: nil, vdop: nil, speed: nil)
      @lat = lat
      @lon = long
      @elevation = elevation
      @time = time
      @hdop = hdop
      @vdop = vdop
      @speed = speed
    end
  end
end
