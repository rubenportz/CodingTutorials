require 'io/console'
require_relative 'Entity'
require_relative 'Maze'

class Game
    attr_accessor :level
    attr_accessor :status
  
    def initialize
      @level = 1
      @status = "Let's get started"
  
      @maze = Maze.new(@level)
    end
  
    def update
      # Player input to move player
      input = STDIN.getch.downcase
  
      if input == "q"
        exit 0
      end
  
      if input == "w"
        @maze.player.move(0, -1)
      elsif input == "s"
        @maze.player.move(0, 1)
      elsif input == "a"
        @maze.player.move(-1, 0)
      elsif input == "d"
        @maze.player.move(1, 0)
      elsif input == "p"
          def this(file)
              file.puts("Level: " + @level.to_s)
              file.puts("Health: #{@maze.player.health}")
              file.puts("Power: #{@maze.player.power}")
              file.puts("Enemy health: #{@maze.enemy1.health}")
              file.puts("Status: " + @status)
              for row in @maze.grid
                  for column in row
                      # floor
                      if column.nil?
                      file.print(" ")
                      else
                      file.print(column.char)
                      end
                  end
              
                  file.puts("")
              end
          end 
          
          file = File.open('gameprint.rb','w')
          this(file)
          file.close()
      else
        @status = "Unknown action, nothing happens."
      end
  
      # Enemy movement
      if @maze.enemy1.health <= 0
        @level = @level + 1
        @maze = Maze.new(@level)
        @status = "Well done! You're now in level #{@level}"
      else
        enenmyMoveY = rand(-1..1)
        enenmyMoveX = rand(-1..1)
        @maze.enemy1.move(enenmyMoveY,enenmyMoveX)
      end
    end
  
    def draw
      system "clear"
  
      # grid
      for row in @maze.grid
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
      puts "Level: " + @level.to_s
      puts "Health: #{@maze.player.health}"
      puts "Power: #{@maze.player.power}"
      puts "Enemy health: #{@maze.enemy1.health}"
      puts "Status: " + @status
      print "WASD to move q to quit: "
    end
  end

  game = Game.new
  
  loop do
    game.draw
    game.update
  end