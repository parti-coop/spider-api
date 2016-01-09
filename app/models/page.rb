class Page < ActiveRecord::Base
  extend Enumerize

  enumerize :loading_status, in: [:not_ready, :success, :fail], default: :not_ready
  validates :url, presence: true, uniqueness: true, url: {no_local: true, message: 'is invalid format'}
end
