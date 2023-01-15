class UsersController < ApplicationController

  def index
    
  end

  def show
    @user = User.find(params[:id])
    @reports = @user.reports.all.order(:client_id)
  end
  
end
