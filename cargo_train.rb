class CargoTrain < Train
  attr_reader :type_train

  def initialize(number)
    super

    @type_train = :cargo
  end
end
