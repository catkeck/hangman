class Word

  attr_reader :value
  
  def initialize
    @value = ["watermelon","pineapple","flatiron","epiphany","computer","orchestra","guacamole","september","firework","jazz","giraffe","gazebo","smoothie","xylophone"].sample
  end

end