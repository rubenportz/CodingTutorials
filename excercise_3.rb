# Using only these core Ruby langauge features:
#
# puts, print, gets.chomp.to_i, if, else, else if, unless, for
# create a programs that ask for dimensions to draw:


# Horizontal line
#
# Enter length: 4
# ####

print "Enter length: "
a = gets.chomp.to_i

for x in 1..a do
  print "#"
end
puts " "

# Vertical line
# Enter length: 4
# #
# #
# #
# #

print "Enter length: "
a = gets.chomp.to_i

for x in 1..a do
  puts "#"
end

# Filled square
#
# Enter length: 4
# ####
# ####
# ####
# ####

print "Enter length: "
a = gets.chomp.to_i

for x in 1..a do
  for x in 1..a do
    print "#"
  end
  puts " "
end

# Outlined square
#
# Enter length: 4
# ####
# #  #
# #  #
# ####

print "Enter length: "
a = gets.chomp.to_i

puts "#" * a
for x in 1..(a-2) do
  puts "#" + " " * (a - 2) + "#"
end
puts "#" * a

# Filled left-leaning triangle
#
# Enter length: 4
# #
# ##
# ###
# ####
# Outlined left-leaning triangle

print "Enter length: "
a = gets.chomp.to_i

for x in 1..a do
  puts "#" * x
end

# Enter length: 6
# #
# ##
# # #
# #  #
# #   #
# ######
# Outlined diamond

print "Enter length: "
a = gets.chomp.to_i

puts "#"
for x in 2..(a - 1) do
  puts "#" + " " * (x - 2) + "#"
end
puts "#" * a

# Enter odd number: 7
#    #
#   # #
#  #   #
# #     #
#  #   #
#   # #
#    #
# Bonus: find out how to, and check, if the number given is odd.

print "Enter odd number: "
a = gets.chomp.to_i

if a.odd?
  for x in 1..a do
    if x > 1 && x < a
      if x < ((a + 1)/2)
        print (" " * (x - ((a + 1) / 2)).abs)
        print "#"
        print (" " * (((((x - ((a + 1) / 2))) + ((a - 1) / 2)) * 2) - 1))
        puts "#"
      else
        print (" " * (x - ((a + 1) / 2)).abs)
        print "#"
        print (" " * (((a - x) * 2) - 1) )
        puts "#"
      end
    else
      if x < ((a + 1)/2)
        print (" " * (x - ((a + 1) / 2)).abs)
        print "#"
        puts (" " * (((((x - ((a + 1) / 2))) + ((a - 1) / 2)) * 2)))
      else
        print (" " * (x - ((a + 1) / 2)).abs)
        print "#"
        puts (" " * (a - x) * 2 )
      end
    end
  end
else
  puts "Number is not odd, exiting"
end
