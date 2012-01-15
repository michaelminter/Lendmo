class CommentsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    params[:comment][:user_id] = params[:user_id]
    params[:comment][:event_id] = params[:event_id]
    logger.debug "params: #{params.inspect}"
    @comment = @event.comments.build(params[:comment])
    
    logger.debug "@event: #{@event.inspect}"
    logger.debug "@comment: #{@comment.inspect}"

    if @comment.save
      redirect_to :back, :notice => "Your comment was successfully posted"
    else
      redirect_to :back, :notice => "Sorry, please try again"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to :back, :notice => "Your comment was successfully deleted"
  end

end
