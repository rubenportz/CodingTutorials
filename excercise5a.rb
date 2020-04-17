require 'io/console'

class Entity
  attr_accessor :x, :y
  attr_accessor :char

  def initialize(grid, x, y, char)
    grid[y][x] = self

    @x = x
    @y = y
    @grid = grid
    @char = char
  end
end

class Wall < Entity
  def initialize(grid, x, y)
    super(grid, x, y, "#")
  end
end

class Weapon < Entity
  def initialize(grid, x, y)
    super(grid, x, y, "T")
  end
end

class Dynamic < Entity
  attr_accessor :power, :health

  def initialize(grid, x, y, char)
    super(grid, x, y, char)

    @power = 0
    @health = 100
  end


  def move(dx, dy)
    # new x and y
    nx = @x + dx
    ny = @y + dy
    if @grid[ny][nx].nil?
      @grid[@y][@x] = nil
      @x = nx
      @y = ny
      @grid[@y][@x] = self
    else
      collision(nx, ny)
    end
  end
end

class Player < Dynamic

  def initialize(grid, x, y)
    super(grid, x, y, "@")
  end

  def collision(nx, ny)
    if @grid[ny][nx].class == Wall
      puts "message"
    elsif @grid[ny][nx].class == Weapon
      @power = @power + 20

      @grid[@y][@x] = nil
      @x = nx
      @y = ny
      @grid[@y][@x] = self

    elsif @grid[ny][nx].class == Enemy
      puts "You bump into an enemy."
      
      
      #Problem
      @health = @health - @power
    end
  end
end

class Enemy < Dynamic
  attr_accessor :health

  def initialize(grid, x, y)
    super(grid, x, y, "K")
  end
end

grid = []
for y in 0..10
  # insert a new array for each row
  # easier to read than the Array.new... stuff
  grid.push([])

  for x in 0..10
    # outer wall
    if x == 0 or y == 0 or x == 10 or y == 10
      Wall.new(grid, x, y)
    end

    # 20% chance to spawn a wall inside
    if rand <= 0.2
      Wall.new(grid, x, y)
    end

    # else grid[y][x] == nil
  end
end

for z in 0..3 do
  x = rand(1..9)
  y = rand(1..9)
  Weapon.new(grid, x, y)
end

x = rand(1..9)
y = rand(1..9)
z = rand(1..9)
w = rand(1..9)

enemy1 = Enemy.new(grid, x, y)
player = Player.new(grid, z, w)

loop do

  system "clear"

  # grid
  for row in grid
    for column in row
      # floor
      if column.nil?
        print " "
      else
        print column.char
      end
    end

    puts ""
  end
  puts "Power: #{player.power}"
  puts "Enemy health: #{enemy1.health}"

  input = STDIN.getch.downcase

  if input == "q"
    exit 0
  end

  if input == "w"
    player.move(0, -1)
  elsif input == "s"
    player.move(0, 1)
  elsif input == "a"
    player.move(-1, 0)
  elsif input == "d"
    player.move(1, 0)
  else
    # $status = "Unknown action, nothing happens."
  end

end
