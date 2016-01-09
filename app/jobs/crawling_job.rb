class CrawlingJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    page = Page.where(loading_status: :not_ready).first
    return if page.nil?
    page.fetch
    page.save!
  end
end
