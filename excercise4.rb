# todo: create empty playing grid
grid = Array.new(3) {Array.new(3, "_")}

# is it player O's turn?
naughts = true

i = 1
j = 1
loop do

  if naughts
    puts " "
    puts "Player O's turn."
    puts "Turn #{i}"
    a = "O"
	  i = i + 1
  else
    puts " "
    puts "Player X's turn."
    puts "Turn #{i}"
    a = "X"
    j = j + 1
  end

  # ask for player input
  puts "Enter x y positon, q to quit: "
  input = gets.chomp

  if input == "q"
    break
  end

  input = input.split " "
  x = input[0]
  y = input[1]

  # check for correct input
  if x.to_i.to_s == x && y.to_i.to_s == y
    x = x.to_i
    y = y.to_i

    #abort if wrong move
    abort "Wrong move" unless grid[y][x] == "_"
    # todo: update grid
    grid[y][x] = a
    # todo: draw grid
    # print grid

    # if I display the grid as below, then the check rules don't work. Not sure yet why?!
    for y in 0..2 do
      for x in 0..2 do
        print grid[y][x]
      end
      puts " "
    end

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

    #cross check
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

    #anti-cross check
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

    #ask for restart in winner scenario
    if winner == true
      puts " "
      puts "Do you want to restart?"
      puts "Enter y to restart, q to quit: "
      input = gets.chomp
      i = 1
      j = 1
      if input == "q"
        break
      end
      if input == "y"
        grid = Array.new(3) {Array.new(3, "_")}
        winner = false
      end
    end

    #check if board is full and ask for restart
    for y in 0..2 do
      for x in 0..2 do
        if grid[y][x] == "_" && winner != true
          break
        elsif grid[y][x] != "_" && y == 2 && x == 2
          puts " "
          puts "There's no winner"
          puts "Do you want to restart?"
          puts "Enter y to restart, q to quit: "
          input = gets.chomp
          i = 1
          j = 1
          if input == "q"
            break
          end
          if input == "y"
            grid = Array.new(3) {Array.new(3, "_")}
            winner = false
          end
        end
      end
    end
  else
    puts "Wrong input."
    naughts = !naughts
  end
  # swap player turn
  naughts = !naughts
end

puts "Goodbye!"
