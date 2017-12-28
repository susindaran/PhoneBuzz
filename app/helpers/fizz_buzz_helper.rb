module FizzBuzzHelper
  def self.convert_number(number)
    if number % 3 == 0 and number % 5 == 0
      return 'Fizz Buzz'
    end

    if number % 3 == 0
      'Fizz'
    elsif number % 5 == 0
      'Buzz'
    else
      number.to_s
    end
  end
end