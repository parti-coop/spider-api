class CrawlingJob
  include Sidekiq::Worker

  def perform(id)
    page = Page.find_by(id: id)
    return if page.nil?

    page.fetch!
  rescue
    if page.present?
      page.update_attributes(loading_status: :unready)
    end
  end
end
