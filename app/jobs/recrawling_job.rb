class RecrawlingJob
  include Sidekiq::Worker

  def perform(reloading_after = 10)
    page = Page.where('updated_at <= ?', reloading_after.days.ago).first
    return if page.nil?

    previous_loading_status = page.loading_status
    page.fetch!
  rescue
    if page.present? and previous_loading_status.present?
      page.update_attributes(loading_status: previous_loading_status)
    end
  end
end
