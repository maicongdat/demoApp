class CommentsController < ApplicationController
  
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, :correct_micropost,   only: :destroy

  def create  
    @comment = current_user.comments.build(comment_params)
    @comment.micropost_id = params[:micropost_id]
    if @comment.save
      flash[:success] = "Comment created!"
      
    else
      @comments = []
      flash[:danger] = "Can not create"
    end
    redirect_to Micropost.find(params[:micropost_id])
  end

  def destroy
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
    def correct_user
      @comment1 = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment1.nil?
    end
    def correct_micropost
      @micropost = Micropost.find(params[:micropost_id])
      redirect_to root_url if @micropost.nil?
    end
end
