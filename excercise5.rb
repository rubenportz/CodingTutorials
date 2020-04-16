require 'io/console'

class Player

  # x y position in the maze
  attr_accessor :x, :y

  attr_reader :char

  attr_accessor :health

  attr_accessor :power

  def initialize(x, y)
    @x = x
    @y = y

    @char = "O"

    @power = 0
  end

  def move(vertical, horizontal)
    # @char = " "
    @x = x + horizontal
    @y = y + vertical
    # @char = "O"
    # system "clear"
  end

end


class Weapon

  # x y position in the maze
  attr_accessor :x, :y

  attr_reader :char

  attr_accessor :power

  def initialize(x, y)
    @x = x
    @y = y

    @char = "T"

    @power = 20
  end

end

class Enemy

  # x y position in the maze
  attr_accessor :x, :y

  attr_reader :char

  attr_accessor :health

  def initialize(x, y)
    @x = x
    @y = y

    @char = "W"

    @health = 100
  end

end


# Set starting level of game
level = 1

# Ask for grid size
puts "Enter width and length (e.g 10 20)"
input = gets.chomp

input = input.split " "
width = input[0]
height = input[1]

# check for correct input
if width.to_i.to_s == width && height.to_i.to_s == height
  width = width.to_i
  height = height.to_i

  # What % of the grid to cover with "#"
  c = (width * height) * 0.2

  loop do
    # Create empty grid
    grid = Array.new(width) { Array.new(height, " ") }

    # Push "#" into grid
    for x in 1..c
      grid[rand(1..(width - 2))][rand(1..(height - 2))] = "#"
    end

    # Push edges into grid
    for w in 0..(width - 1)
      for v in 0..(height - 1)
        grid[0][v] = "#"
        grid[width - 1][v] = "#"
        grid[w][0] = "#"
        grid[w][height - 1] = "#"
      end
    end

    # Create random position coordinates for weapon, player & enemy
    positionX = ((1...(width-2)).sort_by{rand})[0..5]
    positionY = ((1...(height-2)).sort_by{rand})[0..5]

    # Create 1 Enemy
    e1 = Enemy.new(positionX[0], positionY[0])
    grid[e1.x][e1.y] = e1.char

    # Create 1 Player
    p1 = Player.new(positionX[1], positionY[1])
    grid[p1.x][p1.y] = p1.char

    # Create 4 Weapons
    for z in 2..5 do
      tz = Weapon.new(positionX[z], positionY[z])
      grid[tz.x][tz.y] = tz.char
    end

    # Print grid
    for w in 0..(width - 1)
      for v in 0..(height - 1)
        print grid[w][v]
      end

      puts " "
    end

    # Loop after player's interaction
    loop do
      puts "Move your player: A W S D"
      puts p1.x, p1.y

      movePlayer = STDIN.getch.downcase

      if movePlayer == "q"
        exit 0

      # Going Up
      elsif movePlayer == "w"

        if grid[(p1.y - 1)][p1.x] == "#"
          p1.power = p1.power - 5
          system "clear"
          puts "Hitting border"

        else

          if grid[(p1.y - 1)][p1.x] == "T"
            p1.power = p1.power + 10
          end

          if grid[(p1.y - 1)][p1.x] == "W"
            e1.health = e1.health - p1.power
            grid[rand(1..(width - 2))][rand(1..(height - 2))] = "W"
          end

          grid[p1.x][p1.y] = " "
          p1.move(0,-1)
          grid[p1.x][p1.y] = "O"
          system "clear"

        end

      # Going Left
      elsif movePlayer == "a"
      # Going Down
      elsif movePlayer == "s"
      # Going Right
      elsif movePlayer == "d"

      else
        system "clear"
        puts "Wrong move"
      end

      # Print grid
      for w in 0..(width - 1)
        for v in 0..(height - 1)
          print grid[w][v]
        end

        puts ""
      end

      puts "Level #{level}"
      puts "Your p1.power is #{p1.power}"

      if e1.health <= 0
        system "clear"
        level = level + 1
        e1.health = 100 + (level * 15)
        p1.power = 0
        c = c * 1.5
        puts "You've won! The next level is Level: #{level}"
        puts "Enemy health is #{e1.health}"
        puts "Level #{level}"
        puts "Your power is #{p1.power}"
        puts p1.x, p1.y

        break
      else
        puts "Enemy health is #{e1.health}"
      end
    end
  end
else
  puts "Wrong input."
end
