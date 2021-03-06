class EventsController < ApplicationController
  def create
    @user = User.find(current_user)
    params[:event][:borrower_id] = @user.id 
    params[:event][:islending] = false
    @event = Event.create(params[:event])
    
    if @event.fb_post
      @user.post_borrow_status(@event, session[:token])
    end
    
    respond_to do |format|
      if @event.save
        format.html{ redirect_to '/feed', :notice => 'Borrow request posted successfully.' }
      else
        format.html{ redirect_to '/feed', :notice => 'Borrow request unsuccessful.' }
      end
    end
  end

  def destroy
  end

end
