# frozen_string_literal: true

# Validates credit card number using Luhn Algorithm
module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)

    # TODO: use the integers in nums_a to validate its last check digit

    # double every second digit
    double_nums = general_nums(nums_a).map.with_index { |num, idx| idx.even? ? num * 2 : num }

    # sum all the individual digits
    sum_digits = sum_each_digits(double_nums)

    # multiply by 9, mod 10
    check_digit = sum_digits * 9 % 10

    # whether the last checksum digit is correct, return (true/false)
    check_digit == last_num(nums_a)
  end

  # From the rightmost digit->reverse
  def general_nums(number)
    number.reverse[1..-1]
  end

  def last_num(number)
    number.reverse[0]
  end

  def sum_each_digits(double_nums)
    double_nums.map do |num|
      # If the result of this doubling operation is greater than 9 (e.g., 8 * 2 = 16)
      # then add the digits of the result (e.g., 16: 1 + 6 = 7)
      digit = num.to_s.chars.map(&:to_i)
      digit.sum
    end.sum
  end
end
