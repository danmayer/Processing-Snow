require 'penrose_snowflake'


def setup
  size displayWidth, displayHeight
  @background = 0
  background @background
  smooth
  
  buffer_x  = 10
  buffer_y  = 10
  @diameter = 100 
end

def draw
  width = rand(20 .. @diameter)
  x_snow = rand(width .. @width) 
  y_snow = rand(width .. @height)
  stroke 255
  penrose = PenroseSnowflake.new(x_snow, y_snow, rand(20 .. width))
  penrose.simulate rand(2 .. 5)
  penrose.render
end

def mouse_pressed
  background @background
end

def key_pressed
  if key == "s"
    saveFrame "frame###.jpg"
  end
end




