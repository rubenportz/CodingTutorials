# todo: create empty playing grid
grid = Array.new(3) {Array.new(3, "_")}

# is it player O's turn?
naughts = true


# game will loop until someone wins or player exits
loop do

  # ask for player input
  if naughts
    puts " "
    puts "Player O's turn"
    a = "O"
  else
    puts " "
    puts "Player X's turn"
    a = "X"
  end

  puts "Enter x y positon, q to quit: "
  input = gets.chomp

  if input == "q"
    break
  end

  input = input.split " "
  x = input[0]
  y = input[1]
  x = x.to_i
  y = y.to_i


  abort "Wrong move" unless grid[x][y] = "_"
  # todo: update grid
  grid[y][x] = a
  # todo: draw grid
  print grid
  # todo: check for winner and break the loop

  #hortizontal check
  for z in 0..2 do
    if grid[y][z] != a
      break
    end
    if z == 2
      puts " "
      puts "Player #{a} is the winner"
      winner = true
    end
  end

  #vertical check
  for z in 0..2 do
    if grid[z][x] != a
      break
    end
    if z == 2
      puts " "
      print "Player #{a} is the winner"
      winner = true
    end
  end

  # #cross check
  for z in 0..2 do
    if grid[z][z] != a
      break
    end
    if z == 2
      puts " "
      print "Player #{a} is the winner"
      winner = true
    end
  end

  # #anti-cross check
  for z in 0..2 do
    if grid[z][(z-2).abs] != a
      break
    end
    if z == 2
      puts " "
      print "Player #{a} is the winner"
      winner = true
    end
  end

  if winner == true
    break
  end

  # swap player turn
  naughts = !naughts
end

puts "Goodbye!"
