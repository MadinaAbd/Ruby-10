require_relative 'company_name'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

class Main
  MENU = [
  { index: 1, title: 'Создать новую стануцию', action: :new_station },
  { index: 2, title: 'Создать новый поезд', action: :new_train },
  { index: 3, title: 'Создать новый вагон', action: :new_wagon },
  { index: 4, title: 'Задать маршрут', action: :new_route },
  { index: 5, title: 'Задать маршрут поезду', action: :set_route_train },
  { index: 6, title: 'Добавить вагон', action: :add_wagon_train },
  { index: 7, title: 'Удалить вагон', action: :remove_wagon },
  { index: 8, title: 'Менять станцию', action: :change_station },
  { index: 9, title: 'Показать станции', action: :view_station_and_trains },
  { index: 10, title: 'Добавить количество места в грузовом вагоне', action: :get_volume! },
  { index: 11, title: 'Добавить количество сидений в вагоне', action: :get_place! }
].freeze

def initialize
  @stations = []
  @routes = []
  @trains = []
  main_menu
end

 def main_menu
    loop do
    puts 'Введите свой выбор'
    MENU.each { |item| puts "#{item [:index]}: #{item[:title]}" }
    choice = gets.chomp.to_i
    need_item = MENU.find { |item| item[:index] == choice }
    send(need_item[:action])
    puts "Введите любую клавишу для продолжения или 'exit' для выхода"
    break if gets.chomp.to_sym == :exit
  end
end

private

def new_station
  puts 'Введите название нового класса:'
  name = gets.chomp.to_sym
  @stations << Station.new(name)
  puts "Created new station: #{name}"
end

def new_train
  type = type_train
  number = train_number
  create_train(type, number)
end

def type_train

    puts 'Введите 1 для создания поезда типа "passenger" '
    puts 'Введите 2 для создания поезда типа "cargo" '
    choise = gets.chomp.to_i
    raise "Неверный ввод, повторите!" unless [1, 2].include?(choise)

    choise
  rescue RuntimeError => e
    puts e
    retry
end

def train_number

    puts 'Введите номер поезда'
    number = gets.chomp.to_s
    raise 'Ошибка, номер поезда не соответствует формату "...-.." попробуйте еще раз!' if number !~ Train::NUMBER

    number
  rescue RuntimeError=> e
    puts e
    retry
end

def create_train(type, number)
  case type
  when 1
    @trains << PassengerTrain.new(number)

  when 2
    @trains << CargoTrain.new(number)
  end
    puts "Создан поезд с номером #{number}"

end



  def new_wagon
    type = wagon_type
    number = wagon_number
    create_wagon(type, number)
    volume = volume
  end



  def wagon_type
    puts 'Введите 1 для создания вагона типа "passenger" '
    puts 'Введите 2 для создания вагона типа "cargo" '
    choise = gets.chomp.to_i
    raise "Неверный ввод, повторите!" unless [1, 2].include?(choise)

    choise
  rescue RuntimeError => e
    puts e
    retry
  end


  def create_wagon (type, number)
    case type
    when 1
      wagon = PassengerWagon.new(number, volume)
    when 2
      wagon = CargoWagon.new(number, volume)
    end
    puts "Создан новый вагон: #{wagon}"
  end


  def wagon_number
    puts 'Введите номер нового вагона'
    number = gets.chomp.to_s
    raise'Ошибка, номер вагона не соответствует формату "...-.." попробуйте еще раз!' if number !~ Train::NUMBER

    number
  rescue RuntimeError => e
    puts e
    retry
  end


  def volume
    puts 'Введите объем или количество сидений в вагоне:'
    volume = gets.chomp.to_f
    raise 'Ошибка' if volume <= 0

    volume
  rescue RuntimeError => e
    puts e
    retry
  end


  def new_route
    begin
    puts "Введите 1 для создания нового маршрута"
    puts "Введите 2 для управления станцией "
    user_choise = gets.chomp.to_i
  raise'Ошибка, попробуйте еще раз!' unless [1, 2].include?(user_choise)

    user_choise
  rescue RuntimeError => e
    puts e
    retry
  end

    case user_choise
    when 1
      puts 'Введите название нового класса:'
      class_route_name = gets.chomp
      puts 'Добавить первую станцию маршрута'
      choise = gets.chomp.to_sym
      @stations[0] = choise
      puts 'Добавить последнюю станцию маршрута'
      last_station = gets.chomp.to_sym
      @stations.push last_station

    when 2
      begin
      puts "Введите 1 для добавления станции в маршрут"
      puts "Введите 2 для удаления станции"
      choise = gets.chomp.to_i


    raise'Ошибка, попробуйте еще раз!' unless [1, 2].include?(user_choise)

    choise
    rescue RuntimeError => e
      puts e
      retry
  end

      case choise
      when 1
        puts 'Введите название новой станции на маршруте'
        name = gets.chomp
        @stations << name

      when 2
        puts 'Введите название станции для удаления'
        name = gets.chomp
        puts 'Введите маршрут для удаления станции'
        @stations.delete(name)

      end
    end
  end

def set_route_train
  puts 'Введите название класса маршрута:'
  name_class_train = gets.chomp
  puts 'Введите название класса маршрута для поезда'
  route_for_set = gets.chomp
  name_class_train.set_route(route_for_set)
end

def add_wagon_train
  puts 'Введите названиe класса поезда для добавления вагонов'
  class_train_name = gets.chomp
  puts 'Введите название класса вагона для добавления в поезд'
  class_wagon_name = gets.chomp
  class_train_name.add_wagon(class_wagon_name)
  puts 'Ошибка, поезд еще не остановился' unless speed.zero?
  puts 'Ошибка типа вагона' unless name_class_train.type_train == class_wagon_name.type
end

def remove_wagon
  uts 'Введите названиe класса поезда для удаления вагоноa'
  class_train_name = gets.chomp
  puts 'Введите название класса вагона для удаления'
  class_wagon_name = gets.chomp
  class_train_name.del_wagon(class_wagon_name)
  puts 'Ошибка, поезд еще не остановился' unless speed.zero?
  puts 'Ошибка типа вагона' unless name_class_train.type_train == class_wagon_name.type
end

def change_station
  puts "Введите 'next' для перехода на следующую станцию"
    .puts "Введите 'back' для перехода на предыдущию станцию."
  user_choise = gets.chomp.to_sym

  case user_choise
  when :next
    puts 'Введите название класса поезда для перехода на следующую станцию'
    class_train_name = gets.chomp
    class_train_name.move_forward

  when :back
    puts 'Введите название класса поезда для перехода на предыдущую станцию'
    class_train_name = gets.chomp
    class_train_name.move_back

  else
    puts 'Ошибка'
  end
end

def view_station_and_trains
  puts 'Введите название класса маршрута для просмотра списка станций'
  class_route_name = gets.chomp
  class_route_name.way
  puts 'Введите название класса станции для просмотра списка поездов на ней'
  name = gets.chomp
  name.trains
end
end

Main.new
