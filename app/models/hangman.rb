class Hangman

  attr_reader :name
  def initialize
    @incorrect_guesses = 0
    @guessed_letters = []
    @word = Word.new
    @current_user = nil
    @hangman = [["_","_","_","_","_","_","_","_","_","_","_","_"," "],
                ["|"," "," "," "," "," "," "," "," "," "," ","|"," "],
                ["|"," "," "," "," "," "," "," "," "," "," "," "," "],
                ["|"," "," "," "," "," "," "," "," "," "," "," "," "],
                ["|"," "," "," "," "," "," "," "," "," "," "," "," "],
                ["|"," "," "," "," "," "," "," "," "," "," "," "," "]]
  end

  def get_name
    puts "Hello! Have you played Hangman before? (Y/N)"
    response = gets.chomp
    if response == "Y"
      #does not work right now
      puts "What is your name?"
      name = gets.chomp
      puts "What secret code did you choose?"
      secret_code = gets.chomp
      if User.check_existence(name, secret_code).nil?
        puts "We do not recognize that you have played before. Please create an account."
        creates_user
      else
        @current_user = User.check_existence(name, secret_code)
        puts "Welcome to Hangman #{@current_user.name}"
      end
    elsif response == "N"
      creates_user
    else 
      puts "I am sorry, please enter Y or N as your response."
      get_name
    end
  end

  def creates_user
    puts "What is your name?"
    name = gets.chomp
    puts "What secret code would you like?"
    secret_code = gets.chomp
    @current_user = User.new(name, secret_code)
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

  def print_hangman
    @hangman.each do |row|
      row.each do |spot|
        print spot
      end
      puts ""
    end
  end

  def hangman_status
    if @incorrect_guesses == 0
      print_hangman
      puts "You have 6 guesses left!"
    elsif @incorrect_guesses == 1
      @hangman[2][11]="o"
      print_hangman
      puts "You have 5 guesses left!"
    elsif @incorrect_guesses == 2
      @hangman[3][11]="|"
      print_hangman
      puts "You have 4 guesses left!"
    elsif @incorrect_guesses == 3
      @hangman[3][10]="/"
      print_hangman
      puts "You have 3 guesses left!"
    elsif @incorrect_guesses == 4
      @hangman[3][12]="\\"
      print_hangman
      puts "You have 2 guesses left!"
    elsif @incorrect_guesses == 5
      @hangman[4][10]="/"
      print_hangman
      puts "You have 1 guess left."
    else
      @hangman[4][12]="\\"
      print_hangman
    end
  end

  def play_game
    get_name
    while (self.check_word_complete == false && self.check_if_lost == false)
      self.hangman_status
      self.get_guess
    end
    if self.check_word_complete
      puts "Congrats! You won!"
      @current_user.wins += 1
    else
      puts "Sorry, you lost. Please try again"
      self.hangman_status
      @current_user.losses +=1
    end
    puts "Your current record is #{@current_user.wins} wins and #{@current_user.losses} losses."
  end
end