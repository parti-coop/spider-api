require 'test_helper'

class CrawlingJobTest < ActiveJob::TestCase
  test "job" do
    CrawlingJob.new.perform(pages(:page2).id)
    pages(:page2).reload
    assert_equal 'http://ogp.me/logo.png', pages(:page2).image
    assert_equal 'completed', pages(:page2).loading_status
  end
end
