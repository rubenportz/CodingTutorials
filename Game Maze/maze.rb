class Maze
    attr_accessor :grid
  
    attr_reader :player, :enemy1
  
    def initialize(level)
      height = 20
      width = 30
  
      @grid = []
  
      for y in 0..height
        # insert a new array for each row
        @grid.push([])
  
        for x in 0..width
          # outer wall
          if x == 0 or y == 0 or x == width or y == height
            Wall.new(@grid, x, y)
          end
        end
      end
  
      #Create rooms that increase a level progresses
      for time in 0..(4 * level) do
        a = rand(2..((width / 2)-2))
        b = rand(2..((height / 2)-2))
        c = (a * 2) + 3
        d = (b * 2) + 3
  
        for yy in b..d do
          for xx in a..c do
            if xx == c or yy == d or xx == a or yy == b
              Wall.new(@grid, xx, yy)
            end
           end
         end
      end
  
      #Create a few doors in some rooms
      for y in 1..(height - 1)
        for x in 1..(width - 1)
          # 10% chance to spawn a wall inside
          if rand <= (0.1 + level * 0.05)
            grid[y][x] = nil
          end
        end
      end
  
      for z in 0..3 do
        x = rand(1..(width - 1))
        y = rand(1..(height - 1))
        Weapon.new(@grid, x, y)
      end
  
      x = rand(1..(width - 1))
      y = rand(1..(height - 1))
      z = rand(1..(width - 1))
      w = rand(1..(height - 1))
  
      @enemy1 = Enemy.new(@grid, x, y)
      @player = Player.new(@grid, z, w)
    end
  end