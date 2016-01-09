require 'test_helper'

class RecrawlingJobTest < ActiveJob::TestCase
  test "job" do
    page = pages(:page2)
    page.loading_status = :fail
    page.updated_at = 2.days.ago
    page.save!

    RecrawlingJob.perform_now(1)
    pages(:page2).reload
    assert_equal 'http://ogp.me/logo.png', pages(:page2).image
    assert_equal 'success', pages(:page2).loading_status
  end
end
