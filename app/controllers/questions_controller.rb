class QuestionsController < ApplicationController
  before_action :load_question, only: [:show]
  def index
    @questions = Question.all
  end

  def show
    @main_comments = Comment.where(parent_id: @question.id, parent_type: Comment::PARENT_TYPE_BY_KEY[:question]).includes(:user)
    @new_comment = Comment.new
  end

  def new
    @question = Question.new
  end

  def create
    question = Question.new(question_params)
    question.title = question.title + " ?" if question.title.present? && question.title.exclude?('?')
    question.user_id = @current_user.id
    unless question.save
      @question = question
      render "new" and return
    end
    redirect_to questions_index_path
  end

  def add_comment
    comment = Comment.new(comment_params)
    comment.user_id = @current_user.id
    unless comment.save
      flash[:notice] = "Unable to add comment !"
    end
    redirect_to "/questions/#{params.dig(:comment, :question_id)}"
  end

  private

  def load_question
    @question = Question.find_by(id: params[:id])
    if @question.blank?
      record_not_found and return
    end
  end

  def question_params
    params.require(:question).permit(:title, :content)
  end

  def comment_params
    params.require(:comment).permit(:parent_id, :content, :parent_type)
  end
end
