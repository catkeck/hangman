class Hangman

  attr_reader :name

  def initialize(new_user=true, current_user = nil)
    @incorrect_guesses = 0
    @guessed_letters = []
    @word = Word.new
    @current_user = current_user
    @new_user = new_user
    @hangman = [["_","_","_","_","_","_","_","_","_","_","_","_"," "],
                ["|"," "," "," "," "," "," "," "," "," "," ","|"," "],
                ["|"," "," "," "," "," "," "," "," "," "," "," "," "],
                ["|"," "," "," "," "," "," "," "," "," "," "," "," "],
                ["|"," "," "," "," "," "," "," "," "," "," "," "," "],
                ["|"," "," "," "," "," "," "," "," "," "," "," "," "]]
  end


  def get_user
    #Determines if user is new
    puts "Hello! Have you played Hangman before? (Y/N)"
    response = gets.chomp
    #If the user has played before, looks up username based on input
    if response == "Y"
      puts "What is your username?"
      username = gets.chomp
      if User.check_existence(username).nil?
        puts "We do not recognize that you have played before. Please try again."
        get_user
      else
        @current_user = User.check_existence(username)
        puts "Welcome to Hangman #{@current_user.username}"
      end
    #if the user is new, creates new user based on input
    elsif response == "N"
      creates_user
    #ensures that input is appropriate
    else
      puts "I am sorry, please enter Y or N as your response."
      get_user
    end
  end

  def creates_user
    #creates a new user based on user input, verifying that username is not taken
    puts "What is your name?"
    username = gets.chomp
    if User.usernames.include? username
      puts "That username is already taken. Please choose another username."
      creates_user
    else
      @current_user = User.new(username)
    end
  end

  def get_guess
    #Displays already guessed letters given that at least one letter has been guessed
    if @guessed_letters.length != 0
      puts "So far, you have guessed #{@guessed_letters.join(", ")}"
    end
    #Asks user for guess
    puts "What is your guess?"
    guess = gets.chomp.downcase
    #checks if guess is within normal alphabet
    if ('a'..'z').include? guess
      #checks if guess was already used
      if @guessed_letters.include? guess
        puts "You have already guessed #{guess}. Please try again."
      else
        #adds guess to guessed letters and responds based on if guess was correct
        @guessed_letters << guess
        if check_letter(guess)
          puts "Correct! #{guess} is in this word."
        else
          @incorrect_guesses +=1
          puts "Sorry, but #{guess} is not in this word."
        end
      end
    else
      #tells user to try again if input was not okay
      puts "Sorry, please enter a letter from a to z."
      get_guess
    end
  end


  def check_word_complete
    #checks if all letters in word have been guessed
    (word_in_letters - @guessed_letters).empty?
  end

  def print_word_progress
    #prints out word with blanks for letters that have not yet been guessed, while showing letters that have been guessed
    word_in_letters.each do |letter|
       if @guessed_letters.include? letter
          print "#{letter} "
      else
        print "_ "
      end
    end
    puts " "
  end

  def check_if_lost
    #checks if user has run out of guesses
    @incorrect_guesses == 6
  end

  def check_letter(letter)
    #checks if word contains letter
    @word.value.chars.include? letter
  end

  def word_in_letters
    #splits word into array of characters
    @word.value.split("")
  end

  def print_hangman
    #prints hangman's current state
    @hangman.each do |row|
      row.each do |spot|
        print spot
      end
      puts ""
    end
  end


  def edit_hangman(incorrect_guesses)
    if incorrect_guesses == 1
      @hangman[2][11]="o"
    elsif incorrect_guesses == 2
      @hangman[3][11]="|"
    elsif incorrect_guesses == 3
      @hangman[3][10] = "/"
    elsif incorrect_guesses == 4
      @hangman[3][12] = "\\"
    elsif incorrect_guesses == 5
      @hangman[4][10] = "/"
    elsif incorrect_guesses == 6
      @hangman[4][12]="\\"
    else
      @hangman
    end
  end

  def hangman_status
    #prints out hangman and word progress throughout the game, editing the hangman array based on the number of incorrect guesses by the user
    print_word_progress
    edit_hangman(@incorrect_guesses)
    print_hangman
    puts "You have #{6-@incorrect_guesses} guesses left!"
  end

  def print_record
    #prints out user's record
    puts "Your current record is #{@current_user.wins} wins and #{@current_user.losses} losses."
    #lets user view current scoreboard
    puts "View scoreboard? (Y/N)"
    scoreboard_response = gets.chomp
    if scoreboard_response == "Y"
      User.scoreboard
    end
  end

  def win_or_lose
    if self.check_word_complete
      puts "Congrats #{@current_user.username}! You won! The word was #{@word.value}."
      @current_user.wins += 1
    else
      puts "Sorry, #{@current_user.username}, you lost. The word was #{@word.value}. Please try again."
      self.hangman_status
      @current_user.losses +=1
    end
  end

  def play_game
    #gets user
    if @new_user == true
      get_user
    end
    #uses conditional to determine if game is still taking place
    while (self.check_word_complete == false && self.check_if_lost == false)
      self.hangman_status
      self.get_guess
    end
    #responds to user based on if user won or lost, and adds to user's wins or losses
    win_or_lose
    print_record
    #allows user to play again if they wish, or to exit the game
    puts "Would you like to play again? (Y/N)"
    response = gets.chomp
    if response == "Y"
      puts "Is the same user going to play? (Y/N)"
      same_user = gets.chomp
      if same_user == "Y"
        game = self.class.new(false, @current_user)
      else
        game = self.class.new
      end
      game.play_game
    end
  end

end
