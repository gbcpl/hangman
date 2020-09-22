require "fileutils"

class Hangman
  attr_accessor :display_word, :word, :rounds, :beggining, :wrong_letter, :name

  @@array_letter = []
  @@display_word = []
  @@wrong_letter = true
  @@beggining = true
  @@rounds = 8

  def initialize
    puts "Welcome to The Hangman!\n
    You will have to find the word chosen by the Computer! 
    In order to do this, you will have to choose one letter per round...
    If the letter is included in the word, we will reveal it!
    Good luck!\n\n"
    puts "Press Enter to continue"
    enter = gets
    if enter == "\n"
      self.dictionary
    end
  end

  def dictionary
    words = []
    print "Computer chooses a word between 8 and 12 letters"
    3.times { 
      print "."
      # sleep 0.5 
    }
    dictionary = File.open '../5desk.txt'
    dictionary.map do |word|
      word.gsub!("\r\n", "")
      if word.length <= 12 && word.length >= 8
        words.push(word)
      end
    end
    @@word = words.sample(1)
    @@word = @@word[0].to_s.upcase
    @@word = @@word.split(//)
    puts "\n#{@@word}"
  end

  def display_word(beggining)
    i = 0
    while i < @@word.length
      if @@beggining == false 
        @@display_word.push("_ ")
        print "#{@@display_word[i]}"
      else
        print "#{@@display_word[i]} "
      end
      i += 1
    end
  end

  def choose_letter
    puts "\n\nWhat letter would you want to discover?"
    letter = gets.upcase.chomp
    @@array_letter.push(letter)
  end

  def match_letter
    @@word.each_with_index do |letter, index|
      if letter == @@array_letter[@@array_letter.length - 1]
          @@display_word[index] = letter
          @@wrong_letter = false
      else
        @@display_word
      end
    end
  end
end

require "yaml"

class Save < Hangman

  def self.ask_save(rounds)
    puts "\n\nDo you want to save your game? (Y/n)"
    save = gets.downcase.chomp
    if save == "y"
      self.saving(rounds)
    end
  end
  
  public
  def self.saving(rounds)
    puts "Please write the name of your save file."
    save_name = "#{gets.downcase.chomp}.yaml"
    saves_directory = FileUtils.mkdir_p '../saves'
    save = {
      :display_word => @@display_word,
      :word => @@word,
      :@@rounds => @@rounds,
      :array_letter => @@array_letter
    }
    File.open(File.join(Dir.pwd, saves_directory, save_name), "w") do |file|
      file.write(save.to_yaml)
      file.close
    end
  end
end

class Load < Hangman

  def self.load(rounds, beggining)
    puts "Do you want to load a save file? (Y/n)"
    yes_no = gets.downcase.chomp
    if yes_no == "y"
      @@beggining = true
      puts "Choose a file (without extension)."
      saves = Dir.entries("../saves")
      puts "#{saves}"
      save_name = "#{gets.downcase.chomp}.yaml"
      saves_directory = FileUtils.mkdir_p '../saves'
      content = File.read (File.join(Dir.pwd, saves_directory, save_name))
      load_hash = YAML::load(content)
      @@array_letter = load_hash[:array_letter]
      @@word = load_hash[:word]
      @@display_word = load_hash[:display_word]
      @@rounds = load_hash[:rounds]
    end
  end
end

class Draw < Hangman

  def self.draw_rounds(rounds)
    @draw_line1 = ["      |\n", "  |   |\n"]
    @draw_line2 = ["      |\n", "  |   |\n"]
    @draw_line3 = ["      |\n", "  O   |\n", " _O   |\n", " _O_  |\n"]
    @draw_line4 = ["      |\n", "  |   |\n"]
    @draw_line5 = ["      |\n", " /    |\n", " / \\  |\n"]
    puts  "\n  ____\n"
    if @@rounds <= 7
      puts @draw_line1[1] 
    else
      puts @draw_line1[0]
    end
    if @@rounds <= 6
      puts @draw_line2[1] 
    else
      puts @draw_line2[0]
    end
    if @@rounds == 5
      puts  @draw_line3[1]
    elsif @@rounds == 4
      puts @draw_line3[2]
    elsif @@rounds <= 3
      puts @draw_line3[3] 
    else
      puts @draw_line3[0]
    end
    if @@rounds <= 2
      puts @draw_line4[1] 
    else
      puts @draw_line4[0]
    end
    if @@rounds == 1
      puts @draw_line5[1] 
    elsif @@rounds <= 0
      puts @draw_line5[2]
    else
      puts @draw_line5[0]
    end
    puts  "______|\n\n"
    sleep 0.5
  end
end

class Game < Hangman
  attr_accessor :rounds, :beggining, :wrong_letter, :display_word, :word

  def self.lets_play
    hangman = Hangman.new
    @@rounds = 8
    @@beggining = false
    Load.load(@@rounds, @@beggining)
    while @@rounds != 0 || @@display_word != @@word 
      Draw.draw_rounds(@@rounds)
      hangman.display_word(@@beggining)
      @@beggining = true
      puts "\n\n#{@@rounds} possibilities left"
      Save.ask_save(@@rounds)
      hangman.choose_letter
      hangman.match_letter
      if @@wrong_letter == true 
        @@rounds -= 1
      end
      @@wrong_letter = true
      if @@rounds == 0
        Draw.draw_rounds(@@rounds)
        puts "LOOSER"
        break
      elsif @@display_word == @@word
        Draw.draw_rounds(@@rounds)
        puts "WINNER"
        break
      end
    end
  end
end 

Game.lets_play

