require 'json'
require_relative 'player.rb'
require_relative 'purse.rb'
require_relative 'questions.rb'

class Game

  def initialize
    @game_number = 0
    @question_number = 0
    @answer_number = 0
    @end_game = false
    @purse = Purse.new
    @player = Player.new
    @questions = Questions.new
    @available_lifelines = ["50/50", "Ask the Audience", "Phone a Friend"]
  end

  def start
    until game_is_over
      system "clear"
      puts "Welcome to Who Wants to Be A Millionare!\n\n"
      retrieve_question
      player_options
      if game_is_over
        start_over?
      end
    end
  end

  def player_options
    puts "Choose an option:"
    puts "[1] Answer Question"
    if @purse.get_value
      puts "[2] Walk Away With #{@purse.get_value}"
    end
    unless @available_lifelines == []
      puts "[3] Use a Lifeline"
    end
    choice = gets.chomp.to_i
    if choice == 1
      evaluate_answer
    elsif choice == 2
      puts "Thanks for playing! You walk away with #{@purse.get_value}!"
      @end_game = true
      game_is_over
    elsif choice == 3
      choose_lifeline
    end
  end

  def retrieve_question
    puts "Question #{@question_number + 1}:"
    puts @questions.get_question
    @answers = @questions.get_choices
    list_answers
  end

  def list_answers
    choice_number = 1
    @answers.each do |choice|
      puts "#{choice_number}. #{choice}"
      choice_number += 1
    end
    puts
  end

  def evaluate_answer
    print "Your Answer: "
    @user_answer = gets.chomp.to_i - 1
    @question_number += 1
    @correct_answer = @questions.get_answer
    if @user_answer == @correct_answer
      @purse.increment
      puts "Correct! You have now earned #{@purse.get_value}!"
    else
      puts "Sorry, wrong answer, you walk away with #{@purse.get_tier_value}."
      @end_game = true
    end
    puts "[ANY KEY] to Continue"
    gets.chomp
  end

  def choose_lifeline
    puts "Please choose a lifeline: "
    number = 1
    
    @available_lifelines.each do |lifeline|
      puts "#{number}. #{@available_lifelines[number-1]}"
      number += 1
    end

    print "Choice: "
    choice = gets.chomp.to_i
    if choice == 1
      @lifeline = @available_lifelines[0]
      @available_lifelines.delete_at(0)
    elsif choice == 2
      @lifeline = @available_lifelines[1]
      @available_lifelines.delete_at(1)
    elsif choice == 3
      @lifeline = @available_lifelines[2]
      @available_lifelines.delete_at(2)
    end

    if @lifeline == "50/50"
      fifty_fifty
    elsif @lifeline == "Ask the Audience"
      ask_audience
    elsif @lifeline == "Phone a Friend"
      phone_friend
    end
  end

  def fifty_fifty
    # @answers = @questions.get_choices
    # correct_answer = @questions.get_answer
    until @answers.length == 2
      number = rand(0..3)
      unless number == @correct_answer
        @answers.delete_at(number)
      end
    end
    system "clear"
    retrieve_question
    player_options
  end

  def ask_audience
  end

  def phone_friend
  end

  def game_is_over
    if @question_number > 15
      return true
    elsif @end_game
      return true
    else 
      return false
    end
  end

  def start_over?
    puts "[1] Play again"
    puts "[2] Quit"
    choice = gets.chomp.to_i
    if choice == 1
      game = Game.new
      game.start
    end
  end
end