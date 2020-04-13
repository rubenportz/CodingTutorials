
puts "Enter width and length (e.g 10 20)"
input = gets.chomp

input = input.split " "
a = input[0]
b = input[1]

# check for correct input
if a.to_i.to_s == a && b.to_i.to_s == b
  a = a.to_i
  b = b.to_i

  # What part of the grid to cover with "#"
  c = (a * b) * 0.2

  # Create grid
  grid = Array.new(a) {Array.new(b, " ")}

  # Push "#" into grid
  for x in 1..c do
    grid[rand(1..(a-2))][rand(1..(b-2))] = "#"
  end

  # Push edges into grid
  for w in 0..(a-1) do
    for v in 0..(b-1) do
      grid[0][v] = "#"
      grid[a-1][v] = "#"
      grid[w][0] = "#"
      grid[w][b-1] = "#"
    end
  end

  # Place "O" & "W" at random start position
  d = rand(1..(a-2))
  e = rand(1..(b-2))
  f = rand(1..(a-2))
  g = rand(1..(b-2))
  grid[d][e] = "O"
  grid[f][g] = "W"

  # Print grid
  for w in 0..(a-1) do
    for v in 0..(b-1) do
      print grid[w][v]
    end
    puts " "
  end

  loop do
    puts "Move your player: A W S D"
    movePlayer = gets.chomp
    if movePlayer == "A"
      if grid[d][(e - 1)] != " "
        system "clear"
        puts "Hitting border"
      else
        grid[d][e] = " "
        e = e - 1
        grid[d][e] = "O"
        system "clear"
      end
    elsif movePlayer == "D"
      if grid[d][(e + 1)] != " "
        system "clear"
        puts "Hitting border"
      else
        grid[d][e] = " "
        e = e + 1
        grid[d][e] = "O"
        system "clear"
      end
    elsif movePlayer == "S"
      if grid[(d + 1)][e] != " "
        system "clear"
        puts "Hitting border"
      else
        grid[d][e] = " "
        d = d + 1
        grid[d][e] = "O"
        system "clear"
      end
    elsif movePlayer == "W"
      if grid[(d - 1)][e] != " "
        system "clear"
        puts "Hitting border"
      else
        grid[d][e] = " "
        d = d - 1
        grid[d][e] = "O"
        system "clear"
      end
    else
      system "clear"
      puts "Wrong move"
    end

    # Print grid
    for w in 0..(a-1) do
      for v in 0..(b-1) do
        print grid[w][v]
      end
      puts " "
    end
  end

else
  puts "Wrong input."
end
