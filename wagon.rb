class Wagon
  include CompanyName
  include InstanceCounter
  include Validation

  attr_accessor :type, :volume, :take_volume

  TYPE = /^(cargo|passenger)$/i

  def initialize(type, volume)
    @volume = volume
    @type = type
    @take_volume = 0
    # validate!
  end

  def free
    @volume - @take_volume
  end

  def take
    @take_volume
  end

  private

  # def validate!
  #   raise 'Введите "cargo" или "passenger".' if type !~ TYPE
  # end
end
