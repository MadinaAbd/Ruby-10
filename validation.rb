module Validation
 FORMAT = /A-Z{0,3}/i

def presebce(value)
 raise "Ошибка" if value.nil?
end

def format(value)
  raise "Ошибка" if value !~ NUMBER
end

def type(value, type)
  raise "Ошибка" unless value.is_a?(type)
end

def valid?
    validate!
    true
    raise
    false
  end

end

