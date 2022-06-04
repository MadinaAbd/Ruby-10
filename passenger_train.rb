class PassengerTrain < Train
  attr_reader :type_train

  def initialize(number)
    super
    @type_train = 'passenger'
  end
end
