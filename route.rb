class Route
  attr_accessor :stations

  def initialize(first, last)
    @stations = [first, last]
  end

  def add_station(way_station)
    @stations.insert(-2, way_station)
  end

  def delete_station(way_station)
    if [stations.first, stations.last].include?(way_station)
      puts 'Error'
    else
      @stations.delete(way_station)
    end
  end

  def way
    @stations.each { |name| print "#{name}," }
  end
end
