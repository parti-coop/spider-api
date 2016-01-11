require 'test_helper'

class RecrawlingJobTest < ActiveJob::TestCase
  test "job" do
    page = pages(:page2)
    page.updated_at = 2.days.ago
    page.save!

    RecrawlingJob.new.perform(1)
    pages(:page2).reload
    assert_equal 'http://ogp.me/logo.png', pages(:page2).image
    assert_equal 'completed', pages(:page2).loading_status
  end
end
