# Using only these core Ruby langauge features:
#
# puts, print, gets.chomp.to_i, if, else, else if, unless, for
# create a programs that ask for dimensions to draw:
#
# Horizontal line
#
# Enter length: 4
# ####



print "Enter length: "
a = gets.chomp.to_i

for x in 1..a do
  print "#"
end
puts ""


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
  puts "#" * a
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


# Lines | Spaces | #
# 1  0  1
# 2  0  2
# 3  1  2
# 4  2  2
# 5  3  2
# 6  0  6




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

for x in 1..a do
  puts (" " * (x - ((a + 1) / 2)).abs) + "#" + (" ") + "#"
end

L | S | x | S | x
1 | 3 | 1 | 0 | 0
2 | 2 | 1 | 1 | 1
3 | 1 | 1 | 3 | 1
4 | 0 | 1 | 5 | 1
5 | 1 | 1 | 3 | 1
6 | 2 | 1 | 1 | 1
7 | 3 | 1 | 0 | 0



 " " * (x - ((a + 1) / 2)).abs + "#" +

(x - ((a + 1) / 2))

-3
-2
-1
0
1
2
3
