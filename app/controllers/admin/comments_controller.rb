class Admin::CommentsController < ApplicationController
  layout nil
  before_action :authorize!
  before_action :load_commentable

  def create
    
    flash[:notice] = "The comment was successfully added."
    logger.debug "The comment was successfully created!"
    logger.debug "Customer profile ID: " + @commentable.id.to_s
     @comment = @commentable.comments.new(comment_params)
     @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.js
      end
    end    
  end

  private

  def load_commentable
    class_object = [CustomerProfile].detect { |c| params[:comment]["#{c.name.underscore}_id"] }
    @commentable = class_object.find(params[:comment]["#{class_object.name.underscore}_id"])  
  end
  
  def comment_params
      params.require(:comment).permit(:content)
  end
end
