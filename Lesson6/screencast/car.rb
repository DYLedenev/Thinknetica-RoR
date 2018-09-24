class Car
  attr_reader :current_rpm
  attr_accessor :number

  NUMBER_FORMAT = /^[a-zA-Z]{1}\d{3}[a-zA-Z]{2}$/i

  def initialize(number)
    @current_rpm = 0
    @number = number
    validate!
  end

  def start_engine
    start_engine! if engine_stopped?
  end

  def valid?
    validate!
  rescue RuntimeError
    false
  end

  def engine_stopped?
    current_rpm.zero?
  end

  protected

  def validate!
    raise 'Number cannot be nil' if number.nil?
    raise 'Number should be at least 6 symbols' if number.length < 6
    raise 'Number has invalid format' if number !~ NUMBER_FORMAT
    true
  end

  def initial_rpm
    700
  end

  def start_engine!
    self.current_rpm = initial_rpm
  end
end
