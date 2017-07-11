### How to Play Hangman ###

Getting Started

This is a classic hangman game built with Ruby. Follow the instructions to play and compare your score with other users!

To get started with the game, first make a pull request via GitHub to access the code. Enter the downloaded hangman folder from your console. Run ruby bin/run.rb from your console.

1. Open up "Terminal" on your computer. You can search for "Terminal" in your Spotlight Search.
2. Once your terminal is open, type 'ls' to list all the directories or files that are available to you. Type 'cd' followed by the name of the directory in which the hangman.rb file is located.
3. When you are inside the directory, run the game by typing ruby bin/run.rb.
4. You have 6 guesses and once they run out, you'll be dead!

____________
|          |
|          o
|         /|\
|         / \
|    


### Building Hangman ###

There are 3 classes: Hangman, Word, and User.

1. Word
  ** Word class is initialized with an array of values that include guess words. To obtain a random element from an array, use .sample.

2. User
  ** User class is initialized with the username, wins and losses. The method will also store the user info at initialization.

  ** User class should be able to store usernames, individual score, and the scoreboard. It should also check if a username is already in use.

3. Hangman
  ** Initialize the Hangman class with the number of incorrect guesses, guessed letters, current user, new user, the hangman board, and a new word.

  ** If the user has played the game before, ask for the username. If the user is new, create a username. Redirect the user if their input is invalid.

  ** Get guess from the user and display their guesses. If the guess is incorrect, increase the incorrect guess by 1.

  ** Check if the word has been completed by the guesses and end the game.

  ** For every incorrect guess, a body part of the man should appear.

  ** At the end of the game, provide the score for the current user and an option to view the scoreboard that includes the scores for all users. A message should appear indicating whether the user has won or lost the game.

  ** Build a separate Hangman#play_game method that executes the above methods.


### Making Edits ###

If you would like to make edits of your own:

1. Fork the repository from the GitHub page.
2. Edit the code locally
3. git add any desired edits
4. Then git commit -m your edits with a description of what you are suggesting.
5. git push your edits so they appear on GitHub.
6. Access your forked version on GitHub and click "New Pull request" to send through your requested edits.
