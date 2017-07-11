class User

  attr_accessor :wins, :losses
  attr_reader :username

  @@all = []

  def initialize(username)
    @username = username
    @wins = 0
    @losses = 0
    @@all << self
  end

  def self.all
    @@all
  end

  def self.check_existence(username)
    self.all.find {|user| user.username.downcase == username.downcase}
  end

  def self.usernames
    self.all.collect { |user| user.username}
  end

  def individual_score
    @wins.to_f / (@wins.to_f + @losses.to_f) * 100.0
  end

  def self.scoreboard
    puts "Username: Wins, Losses, Scores"
    self.all.each do |user|
      puts "#{user.username}: #{user.wins}, #{user.losses}, #{user.individual_score.floor}%"
    end
  end

end
