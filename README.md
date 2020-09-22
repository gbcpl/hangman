Playing The Hangman

Notes: a class variable in a parent class can be read by the child class.
Don't forger the super
-----------------

The Hangman class

  The dictionary method
The Computer randomly chooses a word of 8-12 letters from a dictionary.
The dictionnary is a .txt file, where each line is a unique word.
We create an array of the word.

  The display word method
The word is shown hidden in the command line => "_" for each number of letters (word length).
We have to create a new array which is exactly the length of the word.
We display the array at each round.

  The choose letter method
The Player has to find the word by choosing a letter each round.
If Player has the right letter, we push that letter to an array. 

  The match letters method
If the word includes the letter chosen by the Player, the letter is shown.
We map the dictionary word to see if there is one or multiple matches.
If there are, we add the letter at the right place(s) in the display word array.

  The rounds loop
Loop ends when word array == display word array
Loop ends when 8 choices failed. 

-----------------

Save class

Each round, the Player can save the game. We have a save class that will be printed in a save file.
The Save file contains the variables.
The variables stores the dictionary word, the letters found array, the number of rounds, the word to display, etc.
The save class inherits from the Game class because we want it to read the variables it contains.
We also want the user to choose the title of the save file.
But we can also choose the Date to write the title of the save files.
We only need to read the variables, so attr_reader.

-----------------

Load class

At the beggining of the program, we are asked if we want to load a save file.
The program checks if there are any save files. 
  If there is none, just show "No save files".
  If there are save files, show a list of the save files. 

We have to find the variables in the txt file and to load them into the game.
We change the variables according to the txt file.
The variables are found in the Game class, so we have to be able to write them (attr_writer).

-----------------

Hangman class

We draw The Hangman after each failed choice 
8 steps as shown below
Way to do this is to store them in an array and add them with a loop linked with rounds variable.
   ____
   |  |
   |  |
  _0_ |
   |  |
  / \ |
______|

Original drawing
   ____
      |
      |
      |
      |
      |
______|






TODOLIST
=> LOAD class
=> READ 5desk.txt from the internet
=> REFACTORING
=> ERROR INPUTS
=> CHECK IF SAVES EXISTS
=> COLOURS
