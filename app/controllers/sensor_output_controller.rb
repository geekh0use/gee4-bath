class SensorOutputController < ApplicationController
  def index
    render json: SensorOutput.latest(100).map(&:display)
  end

  def latest
    render json: SensorOutput.latest.display
  end

  def by_date
    date = Date.parse(params[:date])
    render json: SensorOutput.in_date(date).order_by_time.map(&:display)
  end

  def create
    sensor_output = JSON.parse(request.body.read)
                        .select { |k| ['ba', 'a1'].include? k }
    SensorOutput.create(sensor_output)
    render json: { result: 'ok' }
  end

  def history
    date = Date.parse(params[:date])
    render json: SensorOutput.history(date)
  end

  def history_today
    render json: SensorOutput.history(Date.current)
  end

  def history_yesterday
    render json: SensorOutput.history(Date.current.yesterday)
  end
end
