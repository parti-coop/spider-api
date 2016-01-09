class RecrawlingJob < ActiveJob::Base
  queue_as :default

  def perform(reloading_after = 10)
    page = Page.where(loading_status: [:success, :fail]).where('updated_at <= ?', reloading_after.days.ago).first
    return if page.nil?
    page.fetch
    page.save!
  end
end
