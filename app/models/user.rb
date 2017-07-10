class User

  attr_accessor :wins, :losses
  attr_reader :name, :special_code

  @@all = []

  def initialize(name, special_code)
    @name = name.downcase
    @special_code = special_code.downcase
    @wins = 0
    @losses = 0
    @@all << self
  end

  def self.check_existence(name, special_code)
    @@all.find {|user| user.name.downcase == name.downcase && user.special_code.downcase == special_code.downcase}
  end

end