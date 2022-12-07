class TimerController < ApplicationController
  def index
    @timerMinutes = cookies[:timer_minutes] || 15
  end
end
