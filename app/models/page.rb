class Page < ActiveRecord::Base
  extend Enumerize

  enumerize :loading_status, in: [:unready, :completed], default: :unready
  validates :url, presence: true, uniqueness: true, url: {no_local: true, message: 'is invalid format'}

  def fetch!
    data = OpenGraph.new(self.url, {headers: {'Accept-Language' => 'ko-KR,ko;q=0.8,en-US;q=0.6,en;q=0.4'}})
    self.metadata = data.metadata.to_json || self.metadata
    self.title = data.title || self.title
    self.image = (data.images[0] if data.images.any?) || self.image
    self.page_type = data.type || self.page_type
    self.description = data.description || self.description
    self.loading_status = :completed
    self.save!
  end

  def unready?
    self.loading_status == :unready
  end
end
