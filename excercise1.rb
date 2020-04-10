#!/usr/bin/env ruby

def number?(obj)
  obj = obj.to_s unless obj.is_a? String
  /\A[+-]?\d+(\.[\d]+)?\z/.match obj
end

a = nil
b = nil
loop do
  puts "Input a number:"
  a = gets.chomp
  if number?(a)
    break
  else
    a = a.to_s
    puts a + " is not a number."
    puts "Please input a number instead."
  end
end

loop do
  puts "Input the 2nd number:"
  b = gets.chomp
  if number?(b)
    break
  else
    b = b.to_s
    puts b + " is not a number."
    puts "Please input a number instead."
  end
end

c = a.to_f  + b.to_f
c = c.to_s
puts "The answer is: " + c
