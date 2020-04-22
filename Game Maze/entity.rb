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
      @power = 20
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
      @health = 100
    end
  end