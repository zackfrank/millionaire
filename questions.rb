class Questions
  def initialize
    file = File.read('questions.json')
    @question_number = 0
    @game_number = rand(0..4)
    @questions = JSON.parse(file)["games"][@game_number]["questions"]
  end

  def get_question
    @this_question = @questions[@question_number]["question"]
    return @this_question
  end

  def get_choices
    @choices = @questions[@question_number]["content"]
    return @choices
  end

  def get_answer
    correct_answer = @questions[@question_number]["correct"]
    @question_number += 1
    return correct_answer
  end

end