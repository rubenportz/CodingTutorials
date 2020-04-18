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
  attr_accessor :strength
  def initialize(grid, x, y)
    super(grid, x, y, "#")

    @strength = 100
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

    # Power goes up as levels progress
    @power = 20 * $level
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

  def collision(nx, ny)
  end
end

class Player < Dynamic

  def initialize(grid, x, y)
    super(grid, x, y, "@")
    @health = 100
  end

  def collision(nx, ny)
    # what type os class is it
    if @grid[ny][nx].class == Wall

      # Reduce health when hitting a wall
      @health = @health - 10

      # Destroy wall by hitting it twice
      @grid[ny][nx].strength = @grid[ny][nx].strength - 50
      if @grid[ny][nx].strength <= 0
        @grid[ny][nx] = nil
      end

    elsif @grid[ny][nx].class == Weapon
      @power = @power + 20

      @grid[@y][@x] = nil
      @x = nx
      @y = ny
      @grid[@y][@x] = self

    elsif @grid[ny][nx].class == Enemy
      puts "You bump into an enemy."
      @grid[ny][nx].health = @grid[ny][nx].health - @power
      if @grid[ny][nx].health <= 0
        @grid[ny][nx] = nil
      end
    end
  end
end

class Enemy < Dynamic
  attr_accessor :health

  def initialize(grid, x, y)
    super(grid, x, y, "K")
    @health = 100 * $level
  end
end


$level = 1
$status = "Let's get started"

loop do
  height = 20
  width = 30
  grid = []
  for y in 0..height
    # insert a new array for each row
    # easier to read than the Array.new... stuff
    grid.push([])
    for x in 0..width
      # outer wall
      if x == 0 or y == 0 or x == width or y == height
        Wall.new(grid, x, y)
      end
    end
  end

  #Create rooms that increase a level progresses
  for time in 0..(4 * $level) do
    a = rand(2..((width / 2)-2))
    b = rand(2..((height / 2)-2))
    c = (a * 2) + 3
    d = (b * 2) + 3
    for yy in b..d do
      for xx in a..c do
        if xx == c or yy == d or xx == a or yy == b
          Wall.new(grid, xx, yy)
        end
       end
     end
  end

  #Create a few doors in some rooms
  for y in 1..(height - 1)
    for x in 1..(width - 1)
      # 10% chance to spawn a wall inside
      if rand <= (0.1 + $level * 0.05)
        grid[y][x] = nil
      end
    end
  end

  for z in 0..3 do
    x = rand(1..(width - 1))
    y = rand(1..(height - 1))
    Weapon.new(grid, x, y)
  end

  x = rand(1..(width - 1))
  y = rand(1..(height - 1))
  z = rand(1..(width - 1))
  w = rand(1..(height - 1))

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

    # Text summary below the grid
    puts "Level: " + $level.to_s
    puts "Health: #{player.health}"
    puts "Power: #{player.power}"
    puts "Enemy health: #{enemy1.health}"
    puts "Status: " + $status
    print "WASD to move q to quit: "

    # Player input to move player
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
      $status = "Unknown action, nothing happens."
    end

    # Enemy movement
    if enemy1.health <= 0
      $level = $level + 1
      $status = "Well done! You're now in level #{$level}"

      # Move enemy when defeated in new level

      x = rand(1..(width - 1))
      y = rand(1..(height - 1))
      enemy1 = Enemy.new(grid, x, y)
      enemy1.health = 100
      break
    else
      enenmyMoveY = rand(-1..1)
      enenmyMoveX = rand(-1..1)
      enemy1.move(enenmyMoveY,enenmyMoveX)
    end
  end
end
