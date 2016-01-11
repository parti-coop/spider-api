require 'test_helper'

class PagesTest < ActionDispatch::IntegrationTest
  test 'page' do
    url = 'http://m.daum.net/'
    refute Page.exists?(url: url)

    get_page(url)
    assert Page.exists?(url: url)
    assert_equal "unready", json["loading_status"]

    previous_pages_count = Page.count
    get_page(url)
    assert_equal previous_pages_count, Page.count
  end

  test 'loading-completed page' do
    url = pages(:page1).url
    get_page(url)

    assert_equal json["image"], pages(:page1).image
  end

  test 'invalid url' do
    url = 'xxx'

    get_page(url)

    refute Page.exists?(url: url)
    assert_response 400
  end

  test 'unready?' do
    refute pages(:page1).unready?
    assert pages(:page2).unready?
  end

  def get_page(url)
    get '/api/v1/page?' + { url: url }.to_query
  end
end
