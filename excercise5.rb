require 'io/console'

# any thing in the grid
# later we will change walls, weapons and other items
# to also be entities instead of chars
class Entity
  attr_accessor :x, :y
  attr_accessor :char

  def initialize(grid, x, y, char)
    # store self in grid
    grid[y][x] = self

    @grid = grid
    @x = x
    @y = y
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

# movable entites like the player and enemies
class Dynamic < Entity
  attr_accessor :health, :power

  def initialize(grid, x, y, char)
    super(grid, x, y, char)

    @health = 0
    @power = 0
  end

  # change in x and y
  def move(dx, dy)
    # new x and y
    nx = @x + dx
    ny = @y + dy

    if @grid[ny][nx].nil?
      # remove from old spot
      @grid[@y][@x] = nil

      # move to new spot
      @x = nx
      @y = ny
      @grid[@y][@x] = self
    else
      collision(nx, ny)
    end
  end

  def collision(nx, ny)
    # handle custom collision logic in extended classes
  end
end

class Player < Dynamic
  def initialize(grid, x, y)
    # in roguelike games the player is traditional represented by @
    # see more standard chars https://www.reddit.com/r/roguelikedev/comments/2fxaks/a_compendium_of_ascii_characters_across_roguelikes/
    super(grid, x, y, "@")
  end

  def collision(nx, ny)
    if @grid[ny][nx].class == Wall
      # add you logic here
      # you see how you could do the same thing in the Enemy class
      # and give it its own collision logic
      $status = "You collide with the wall, "

      i = (rand * 3).to_i

      case i
      when 0
        $status += "it hurts!"
      when 1
        $status += "it doesn't budge."
      when 2
        $status += "oof!!!"
      end
    elsif @grid[ny][nx].class == Weapon
      $status = "You bump into a weapon."
    elsif @grid[ny][nx].class == Enemy
      $status + "You bump into an enemy."
    end
  end
end

class Enemy < Dynamic
  def initialize(grid, x, y)
    super(grid, x, y, "K")
    @health = 100
  end
end

# Set starting level of game
level = 1
# status string you can use to show messages
# $ meens it is a global variable so we can access it in our objects
# this is normally bad practice and this var should be part of another class
$status = "Your adventure begins."

# it would be good to encapsulate the map/grid variables into a class
width = 40
height = 20


#
# Initialise the world
#

# the grid starts off as an empty array
# this could be moved to its own clas
grid = []

for y in 0..(height - 1)
  # insert a new array for each row
  # easier to read than the Array.new... stuff
  grid.push([])

  for x in 0..(width - 1)
    # outer wall
    if x == 0 or y == 0 or x == width - 1 or y == height - 1
      Wall.new(grid, x, y)
    end

    # 20% chance to spawn a wall inside
    if rand <= 0.2
      Wall.new(grid, x, y)
    end

    # else grid[y][x] == nil
  end
end

# create weapons
for i in 1..10
  # it would be better to put this in the Wall initialize
  x = 1 + (rand * (width - 2))
  y = 1 + (rand * (height - 2))
  grid[y][x] = Weapon.new(grid, x, y)
end

# enemy
# it would be better to put this in the enemy initialize
# so all you would do is e1 = Enemy.new(grid)
x = 1 + (rand * (width - 2))
y = 1 + (rand * (height - 2))
# we need a reference to it
e1 = Enemy.new(grid, x, y)

# player
# it would be better to put this in the player initialize
# so all you would do is player = Player.new(grid)
x = 1 + (rand * (width - 2))
y = 1 + (rand * (height - 2))
# we need a reference to it
player = Player.new(grid, x, y)


#
# Game loop
#

# the game loop of drawing, handling input and increasing the difficulty
# can also be moved to its own class
loop do

  #
  # Draw
  #

  # notice I moved things around to only draw in one place

  system "clear"

  # grid
  for row in grid
    for e in row
      # floor
      if e.nil?
        print " "
      else
        print e.char
      end
    end

    puts ""
  end

  puts "Level: #{level}"
  puts "Power: #{player.power}"
  puts "Enemy health: #{e1.health}"
  puts "Status: " + $status
  print "WASD to move q to quit: "


  #
  # Input
  #
  $status = "You're standing on an empty floor."

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


  #
  # game logic after movement and collisions
  #

  # if e1.health <= 0
  #   level = level + 1

  #   e1.health = 100 + (level * 15)
  #   p1.power = 0

  #   c = c * 1.5
  # end

end
