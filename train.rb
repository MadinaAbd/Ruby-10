class Train
  include InstanceCounter
  include CompanyName
  include Validation


  attr_accessor :speed, :number, :wagons, :route, :type, :stations

  @@trains = []

  NUMBER = /^[a-z\d]{3}-*[a-z\d]{2}$/i

  def initialize(number)
    @number = number
    @wagons = []
    @@trains << self
  end

  def self.find(number)
    @@trains.find { |train| train.number == number }
  end

  def all_wagons
    @wagons.each { |train| puts train }
  end

  def get_speed(speed)
    @speed = speed
  end

  def stop
    self.speed = 0
  end

  def current_speed
    @speed
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero? && type_train == wagon.type
  end

  def del_wagon(wagon)
    @wagons.delete wagon if @speed.zero? && type_train == wagon.type
  end

  def get_route(route)
    @route = route
    @station_index = 0
    current_station.add_train(self)
  end

  def current_station
    return unless @route

    @route.route[station_index]
  end

  def next_station
    return unless @route

    @route.route[@station_index + 1]
  end

  def prev_st
    return unless @route
    return if @station_index < 1

    @route.route[@station_index - 1]
  end

  def move_back
    return unless @route && prev_st

    current_station.send(self)
    @station_index -= 1
    current_station.add_train(self)
  end

  def move_forward
    return unless @route && next_st

    current_station.send(self)
    @station_index += 1
    current_station.add_train(self)
  end

end
