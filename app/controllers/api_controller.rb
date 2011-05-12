class ApiController < ApplicationController

  def at
    Job.create!(
      :at => DateTime.parse(params[:datetime]),
      :url => params[:url],
      :retries => 0
    )
    head :ok
  end

  def in
    Job.create!(
      :at => params[:n].to_i.send(params[:unit]).from_now,
      :url => params[:url],
      :retries => 0
    )
    head :ok
  end

  def every
    Job.create!(
      :at => DateTime.now,
      :url => params[:url],
      :interval => params[:n].to_i.send(params[:unit]) / 1.minute,
      :retries => 0
    )
    head :ok
  end

end