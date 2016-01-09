
class Page < ActiveRecord::Base
  extend Enumerize

  enumerize :loading_status, in: [:not_ready, :success, :fail], default: :not_ready
  validates :url, presence: true, uniqueness: true, url: {no_local: true, message: 'is invalid format'}

  def fetch
    data = OpenGraph.new(self.url)
    if data
      self.source = data.to_json
      self.image = data.images[0] if data.images.any?
      self.page_type = data.type
      self.description = data.description
      self.loading_status = :success
    else
      self.loading_status = :fail
    end
  end
end
