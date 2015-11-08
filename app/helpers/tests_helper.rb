module TestsHelper

  def isChecked(answer)
    answer.correct && answer.anserw.correct || !answer.correct && !answer.anserw.correct;
  end

  def resultShowClass(answer)
    answer.correct ? 'user-correct-answer' : 'user-incorrect-answer'
  end
end
