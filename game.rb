require 'json'
require_relative 'player.rb'
require_relative 'purse.rb'
require_relative 'questions.rb'

class Game

  def initialize
    @game_number = 0
    @question_number = 0
    @answer_number = 0
    @purse = Purse.new
    @player = Player.new
    @questions = Questions.new
  end

  def start
    until game_is_over
      system "clear"
      puts "Welcome to Who Wants to Be A Millionare!\n\n"
      retrieve_question
      evaluate_answer
    end
  end

  def retrieve_question
    puts "Question #{@question_number + 1}:"
    puts @questions.get_question
    choice_number = 1
    @questions.get_choices.each do |choice|
      puts "#{choice_number}. #{choice}"
      choice_number += 1
    end
    print "Your Answer: "
    @user_answer = gets.chomp.to_i - 1
    @question_number += 1
  end

  def evaluate_answer
    answer = @questions.get_answer
    if @user_answer == answer
      @purse.increment
      puts "Correct! You have now earned #{@purse.get_value}!"
    else
      puts "So sorry, wrong answer, good luck in life!"
      @question_number = 100
    end
    puts "[ANY KEY] to Continue"
    gets.chomp
  end

  def game_is_over
    if @question_number > 15
      return true
    else 
      return false
    end
  end
end