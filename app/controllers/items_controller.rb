class ItemsController < ApplicationController
  def create
    params[:item][:borrower_id] = params[:borrower_id]
    params[:item][:user_id] = params[:user_id]
    params[:item][:value] = params[:value]
    @user = User.find(current_user)
    @item = @user.items.build(params[:item])
    @borrower = User.find(@item.borrower_id)
    
    respond_to do |format|
      if @item.save
        @user.lend(@item, @borrower)
        format.html { redirect_to '/feed', :notice => 'Lent sucessfully.' }
      else
        format.html { redirect_to '/feed', :notice => 'Lending unsucessful.' }
      end
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @item = Post.find(params[:id])
    @user.return(@item)
    
    respond_to do |format|
      format.html { redirect_to @user, :notice => 'Successfully returned ' + @item.name + ' to ' + @user.name }
      format.json { head :ok }
    end
  end

end
