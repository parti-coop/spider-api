class Page < ActiveRecord::Base
  extend Enumerize

  enumerize :loading_status, in: [:unready, :completed], default: :unready
  validates :url, presence: true, uniqueness: true, url: {no_local: true, message: 'is invalid format'}

  def fetch!
    data = OpenGraph.new(self.url)
    self.metadata ||= data.metadata.to_json
    self.title ||= data.title
    self.image ||= data.images[0] if data.images.any?
    self.page_type ||= data.type
    self.description ||= data.description
    self.loading_status = :completed
    self.save!
  end

  def unready?
    self.loading_status == :unready
  end
end
