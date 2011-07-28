require 'net/http'

class Job < ActiveRecord::Base
  MAX_RETRIES = 5

  def self.run_loop
    Job.where('at <= ?', DateTime.now).find_each do |job|
      job.run
    end
  end

  def run
    if recurrent?
      # schedule next cycle
      self.at = interval.minutes.from_now
    else
      self.retries += 1
      return delete if retries > MAX_RETRIES
      # schedule next retry
      self.at = 5.seconds.from_now
    end
    save!

    begin
      Net::HTTP.get URI.parse(url)
    rescue Exception => ex
      puts ex.message
      delete if retries >= MAX_RETRIES
      return
    end
    delete unless recurrent?
  end

  def recurrent?
    interval.present? && interval > 0
  end

end
