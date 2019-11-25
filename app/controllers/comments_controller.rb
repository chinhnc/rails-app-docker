class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :find_micropost,   only: :create

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.micropost_id = @micropost.id

    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to @micropost
    else
      flash[:danger] = "Cann't create comment!"
      redirect_to @micropost
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to request.referrer || root_url
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end

    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end

    def find_micropost
      @micropost = Micropost.find(params[:micropost_id])
    end

    def find_comment
      @comment = Comment.find(params[:id])
    end
end
