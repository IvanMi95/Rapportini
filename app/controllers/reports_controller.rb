class ReportsController < ApplicationController

  def index
    if user_signed_in?
      if current_user.admin?    
        @reports = Reports.all.order(:client_id)
      else
        @reports = Report.where(user_id: current_user.id).order(:client_id)
      end
      respond_to do |format|
        format.html
        format.csv { send_data Report.to_csv, filename: "reports-#{DateTime.now.strftime("%d%m%Y%H%M")}.csv" }
      end
    else
      redirect_to  new_user_session_path
    end
  end

  def show
    @report = Report.find(params[:id])
    @client = @report.client
    @user = @report.user
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    if @report.save!
      flash[:info] = 'Raportino aggiunto'
      redirect_to @report
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @report.update(report_params)
      flash[:success] = 'Raportino aggiornato'
      redirect_to @report
    else
      redner 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.admin? 
        Report.find(params[:id]).destroy
        flash[:success] = 'Raportino cancelatto'
        redirect_to reports_url, status: :see_other
    end
  end

  private

  def report_params
    # changed name of key for easier creation
    params['client_id'] = params['id']
    params.delete('id')

    params.permit(:description, :material, :hours, :user_id, :client_id)
  end

  def current_report
    @current_report = Report.find(params[:id])
  end

end
