# provides possibility of validating user input
module Validation
  def valid_station?(name)
    validate_station_name!(name)
  rescue
    false
  end

  def valid_train_number?(train_number)
    validate_train_number!(train_number)
  rescue
    false
  end

  protected

  NUMBER_FORMAT = /^\w{3}\-*\w{2}$/im

  def validate!(what)
    raise 'Value cannot be empty' if what.empty?
    true
  end

  def validate_station_name!(name)
    validate!(name)
    raise 'Name should contain at least 2 letters' if name.size < 2
    true
  end

  def validate_train_number!(train_number)
    validate!(train_number)
    raise 'Incorrect number format (try ххх-хх OR xxxxx)' unless train_number =~ NUMBER_FORMAT
    true
  end

  def validate_type!(type)
    raise 'Select between 1 or 2' unless type.between?(1, 2)
    true
  end
end
