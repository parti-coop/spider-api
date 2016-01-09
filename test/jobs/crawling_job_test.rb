require 'test_helper'

class CrawlingJobTest < ActiveJob::TestCase
  test "job" do
    CrawlingJob.perform_now
    assert_equal 'http://ogp.me/logo.png', pages(:page2).image
    assert_equal 'success', pages(:page2).loading_status
  end
end
