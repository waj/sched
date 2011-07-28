require 'test_helper'

class JobTest < ActiveSupport::TestCase
  test "job run loop" do
    j1 = Job.create! :at => 10.minutes.ago
    j2 = Job.create! :at => 1.minute.ago
    j3 = Job.create! :at => 2.minutes.from_now

    j1.expects(:run).once
    j2.expects(:run).once
    j3.expects(:run).never

    Job.run_loop
  end
end
