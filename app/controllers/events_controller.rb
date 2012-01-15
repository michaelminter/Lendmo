class EventsController < ApplicationController
  def create
    params[:event][:borrower_id] = params[:borrower_id]
    params[:event][:islending] = false
    @user = User.find(current_user)
    @event = Event.build(params[:event])
    
    respond_to do |format|
      if @event.save
        format.html{ redirect_to '/feed', :notice => 'Borrow request posted successfully.' }
      else
        format.html{ redicrect_to '/feed', :notice => 'Borrow request unsuccessful.' }
      end
    end
  end

  def destroy
  end

end
