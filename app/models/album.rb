class Album < ActiveRecord::Base
  validates :title, presence: true
  validates :artist, presence: true
  validates :host, presence: true
  validates :played_on, presence: true

  default_scope :order => 'played_on DESC'
end
