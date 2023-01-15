class ClientsController < ApplicationController

  before_action :admin_user, only: [:destroy, :update]

  def index
    @clients = Client.all
  end

  def show
    @client = Client.find(params[:id])
    #@reports = @client.reports.paginate(page: params[:page])
  end
  
  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      flash[:info] = 'Cliente aggiunto.'
      redirect_to @client
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @client.update(client_params)
      flash[:success] = 'Cliente aggiornato'
      redirect_to @client
    else
      redner 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    Client.find(params[:id]).destroy
    flash[:success] = 'Cliente rimosso'
    redirect_to clients_url, status: :see_other
  end
  
  private

  def client_params
    params.require(:client).permit(:name, :email, :phone, :address)
  end

  def current_client
    @current_client = Client.find(params[:id])
  end
  
  def admin_user
    current_user.admin? 
  end

end
