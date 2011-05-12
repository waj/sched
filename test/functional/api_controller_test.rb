require 'test_helper'

class ApiControllerTest < ActionController::TestCase

  test "schedule at date/time" do
    get :at, :datetime => '2011-12-25T10:00:00', :url => 'http://my-url.com/'
    job = Job.first
    assert_equal DateTime.parse('2011-12-25T10:00:00'), job.at
    assert_equal 'http://my-url.com/', job.url
    assert_equal 0, job.retries
  end

  test "schedule in some time" do
    get :in, :n => 3, :unit => 'minutes',  :url => 'http://my-url.com/'
    job = Job.first
    assert_equal 3.minutes.from_now.to_i, job.at.to_i
    assert_equal 'http://my-url.com/', job.url
    assert_equal 0, job.retries
  end

  test "schedule every time" do
    get :every, :n => 4, :unit => 'hours', :url => 'http://my-url.com/'
    job = Job.first
    assert_equal DateTime.now.to_i, job.at.to_i
    assert_equal 'http://my-url.com/', job.url
    assert_equal 0, job.retries
    assert_equal 240, job.interval
  end

end
