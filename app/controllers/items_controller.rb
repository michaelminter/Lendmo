class ItemsController < ApplicationController
  def create
    @user = User.find(current_user)
    @item = @user.items.build(params[:item])
    @borrower = User.find(@item.borrower_id)
    
    respond_to do |format|
      if @item.save
        @user.lend(@item, @borrower, session[:token])
        borrow_request = Event.where("borrower_id = ? AND item_name = ?", @borrower.id, @item.name).last
        borrow_request.destroy
        
        format.html { redirect_to '/feed', :notice => 'Lent sucessfully.' }
      else
        format.html { redirect_to '/feed', :notice => 'Lending unsucessful.' }
      end
    end
  end

  def destroy
    @user  = User.find(params[:user_id])
    @item  = Item.find(params[:id])
    @event = Event.find(params[:event_id])

    @user.give_back(@item)
    @event.destroy
    
    respond_to do |format|
      format.html { redirect_to @user, :notice => 'Successfully returned ' + @item.name + ' to ' + @user.name }
      format.json { head :ok }
    end
  end
  
  def open_graph
    @item = Item.find(params[:id])
    render :partial => "layouts/graph_item"
  end

end
