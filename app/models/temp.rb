require 'pry'

class User

  attr_accessor :wins, :losses
  attr_reader :name

  def initialize(name)
    @name = name
    @wins = 0
    @losses = 0
  end

end

class Hangman

  def initialize
    @incorrect_guesses = 0
    @guessed_letters = []
    @word = Word.new
  end


  def welcome
    puts "Hello person, welcome to Hangman!"
  end

  def get_guess
    puts "What is your guess?"
    guess = gets.chomp
    if @guessed_letters.include? guess
      puts "You have already guessed #{guess}. Please try again."
    else
      @guessed_letters << guess
      if check_letter(guess)
        puts "Correct! #{guess} is in this word."
        0.upto(@word.value.length-1) do |i|
          if @guessed_letters.include? word_in_letters[i] 
            print "#{word_in_letters[i] }"
          else 
            print "_ "
          end
        end
        puts " "
      else
        @incorrect_guesses +=1
        puts "Sorry, but #{guess} is not in this word."
      end
    end
  end

  def check_word_complete
    (word_in_letters - @guessed_letters).empty?
  end

  def check_if_lost
    @incorrect_guesses == 6
  end

  def check_letter(letter)
    @word.value.chars.include? letter
  end

  def word_in_letters
    @word.value.split("")
  end

  def hangman_status
    if @incorrect_guesses == 0
      puts "____________"
      puts "|           |"
      puts "|"
      puts "|"
      puts "|"
      puts "|"
      puts "You have 6 guesses left!"
    elsif @incorrect_guesses == 1
      puts "____________"
      puts "|           |"
      puts "|           o"
      puts "|"
      puts "|"
      puts "|"
      puts "You have 5 guesses left!"
    elsif @incorrect_guesses == 2
      puts "____________"
      puts "|           |"
      puts "|           o"
      puts "|           |"
      puts "|"
      puts "|"
      puts "You have 4 guesses left!"
    elsif @incorrect_guesses == 3
      puts "____________"
      puts "|           |"
      puts "|           o"
      puts "|          /|"
      puts "|"
      puts "|"
      puts "You have 3 guesses left!"
    elsif @incorrect_guesses == 4
      puts "____________"
      puts "|           |"
      puts "|           o"
      puts "|          /|\\"
      puts "|"
      puts "|"
      puts "You have 2 guesses left!"
    elsif @incorrect_guesses == 5
      puts "____________"
      puts "|           |"
      puts "|           o"
      puts "|          /|\\"
      puts "|          /"
      puts "|"
      puts "You have 1 guess left."
    else
      puts "____________"
      puts "|           |"
      puts "|           o"
      puts "|          /|\\"
      puts "|          / \\"
      puts "|"
      puts "You are dead. Goodbye."
    end
  end

end

class Word

  attr_reader :value
  
  def initialize
    @value = "watermelon"
  end

end

user = User.new("Caitlin")
game = Hangman.new
game.welcome
while (game.check_word_complete == false && game.check_if_lost == false)
  game.hangman_status
  game.get_guess
end
if game.check_word_complete
  puts "Congrats! You won!"
  user.wins += 1
else
  puts "Sorry, you lost. Please try again"
  game.hangman_status
  user.losses +=1
end