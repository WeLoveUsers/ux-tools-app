class AppNotificationsController < ApplicationController
  before_action :set_app_notification, only: [:mark_as_read, :show, :edit, :update, :destroy]

  before_action :authenticate_user!
  before_action :authenticate_admin_user, only: [:index, :show, :new, :edit, :create, :update, :destroy]

  # GET /app_notifications/mark_as_read/1
  # GET /app_notifications/mark_as_read/1.json
  def mark_as_read
    @read_app_notification = ReadAppNotification.new()
    @read_app_notification.app_notification = @app_notification
    @read_app_notification.user = current_user
    respond_to do |format|
      if @read_app_notification.save
        format.html { redirect_back fallback_location: root_url }
        format.json { render :mark_as_read, status: :created }
      else
        format.html { render :new }
        format.json { render json: @read_app_notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /app_notifications
  # GET /app_notifications.json
  def index
    @app_notifications = AppNotification.all.order(date: :desc)
  end

  # GET /app_notifications/1
  # GET /app_notifications/1.json
  def show
    redirect_to app_notifications_url, notice: 'Desactivé...'
  end

  # GET /app_notifications/new
  def new
    @app_notification = AppNotification.new
  end

  # GET /app_notifications/1/edit
  def edit
  end

  # POST /app_notifications
  # POST /app_notifications.json
  def create
    @app_notification = AppNotification.new(app_notification_params)

    respond_to do |format|
      if @app_notification.save
        format.html { redirect_to app_notifications_url, notice: 'App notification was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @app_notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /app_notifications/1
  # PATCH/PUT /app_notifications/1.json
  def update
    respond_to do |format|
      if @app_notification.update(app_notification_params)
        format.html { redirect_to app_notifications_url, notice: 'App notification was successfully updated.' }
        format.json { render :show, status: :ok, location: @app_notification }
      else
        format.html { render :edit }
        format.json { render json: @app_notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /app_notifications/1
  # DELETE /app_notifications/1.json
  def destroy
    @app_notification.destroy
    respond_to do |format|
      format.html { redirect_to app_notifications_url, notice: 'App notification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app_notification
      @app_notification = AppNotification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_notification_params
      params.require(:app_notification).permit(:date, :notification_type, :title, :content)
    end
end
