class PenroseSnowflake
  include Processing::Proxy

  attr_accessor :axiom, :rule, :start_length, :theta, :production, :draw_length, 
    :repeats, :xpos, :ypos
  DELTA = (Math::PI/180) * 18.0 # convert degrees to radians

  def initialize(xpos = 500, ypos = 500, size = 75)
    @axiom        = "F3-F3-F3-F3-F"
    @rule         = "F3-F3-F45-F++F3-F"
    @start_length = size
    @size         = size
    @theta        = 0
    @xpos         = xpos
    @ypos         = ypos
    reset
  end
  
  def render()
    repeats = 1
    production.split("").each do |element|
      case element
      when 'F'
        line(xpos, ypos, (@xpos -= multiplier(repeats, :cos)), (@ypos += multiplier(repeats, :sin)))
        repeats = 1
      when '+'
        @theta += DELTA * repeats
        repeats = 1
      when '-'
        @theta -= DELTA * repeats
        repeats = 1
      when '3', '4', '5'
        repeats += Integer(element)
      else puts "Grammar not recognized"  
      end
    end
  end
  
  def simulate gen
    gen.times do      
      @production = iterate(production, rule)         
    end
  end

  private

  def reset # initialize or reset variables
    @production  = axiom
    @draw_length = start_length
  end

  def multiplier(repeats, type)
    value = draw_length * repeats
    value = case type
            when :cos
              value * Math.cos(theta)
            when :sin
              value *  Math.sin(theta)
            end
  end
  
  ##############################################################################
  # Not strictly in the spirit of either processing or L-Systems in my iterate
  # function I have ignored the processing translate/rotate functions in favour
  # of the direct calculation of the new x and y positions, thus avoiding such
  # affine transformations.
  ##############################################################################
  def iterate(prod_, rule_)
    new_production = ""
    production.split("").each do |prod|
      new_production. << rule if prod == 'F'
      new_production. << prod if prod != 'F'
    end
    @draw_length *=  0.4
    return new_production
  end

end
