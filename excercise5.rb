level = 1
# Ask for grid size
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

  loop do
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
    h = rand(1..(a-2))
    i = rand(1..(b-2))
    j = rand(1..(a-2))
    k = rand(1..(b-2))
    l = rand(1..(a-2))
    m = rand(1..(b-2))
    n = rand(1..(a-2))
    o = rand(1..(b-2))
    grid[d][e] = "O"
    grid[f][g] = "W"
    grid[h][i] = "T"
    grid[j][k] = "T"
    grid[l][m] = "T"
    grid[n][o] = "T"

    power = 0
    health = 100

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
        if grid[d][(e - 1)] == "#"
          power = power - 5
          system "clear"
          puts "Hitting border"
        else
          if grid[d][(e - 1)] == "T"
            power = power + 10
          end
          if grid[d][(e - 1)] == "W"
            health = health - power
            grid[rand(1..(a-2))][rand(1..(b-2))] = "W"
          end
          grid[d][e] = " "
          e = e - 1
          grid[d][e] = "O"
          system "clear"
        end
      elsif movePlayer == "D"
        if grid[d][(e + 1)] == "#"
          power = power - 5
          system "clear"
          puts "Hitting border"
        else
          if grid[d][(e + 1)] == "T"
            power = power + 10
          end
          if grid[d][(e + 1)] == "W"
            health = health - power
            grid[rand(1..(a-2))][rand(1..(b-2))] = "W"
          end
          grid[d][e] = " "
          e = e + 1
          grid[d][e] = "O"
          system "clear"
        end
      elsif movePlayer == "S"
        if grid[(d + 1)][e] == "#"
          power = power - 5
          system "clear"
          puts "Hitting border"
        else
          if grid[(d + 1)][e] == "T"
            power = power + 10
          end
          if grid[(d + 1)][e] == "W"
            health = health - power
            grid[rand(1..(a-2))][rand(1..(b-2))] = "W"
          end
          grid[d][e] = " "
          d = d + 1
          grid[d][e] = "O"
          system "clear"
        end
      elsif movePlayer == "W"
        if grid[(d - 1)][e] == "#"
          power = power - 5
          system "clear"
          puts "Hitting border"
        else
          if grid[(d - 1)][e] == "T"
            power = power + 10
          end
          if grid[(d - 1)][e] == "W"
            health = health - power
            grid[rand(1..(a-2))][rand(1..(b-2))] = "W"
          end
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
        puts ""
      end
      puts "Level #{level}"
      puts "Your power is #{power}"
      if health <= 0
        system "clear"
        level = level + 1
        health = 100 + (level * 15)
        power = 0
        c = c * 1.5
        puts "You've won! The next level is Level: #{level}"
        puts "Enemy health is #{health}"
        puts "Level #{level}"
        puts "Your power is #{power}"
        break
      else
        puts "Enemy health is #{health}"
      end
    end
  end

else
  puts "Wrong input."
end
