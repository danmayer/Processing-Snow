require 'penrose_snowflake'

class Sketch < Processing::App
  def new(params)
    @width = params[:width]
    @height = params[:height]
    super
  end

  def setup
    @background = 0
    background @background
    smooth
    
    buffer_x  = 10
    buffer_y  = 10
    @diameter = 100 
  end

  def draw
    width = get_rand(20,@diameter)
    x_snow = get_rand(width,@width) 
    y_snow = get_rand(width,@height)
    stroke 255
    penrose = PenroseSnowflake.new(x_snow, y_snow, get_rand(20,width))
    penrose.simulate get_rand(2,5)
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
  
  def get_rand(min = 0, max = 1000)
    min + rand((max - min))
  end
  
end

Sketch.new(:width => 1024, :height => 768, :title => "Snow", :full_screen => true)
