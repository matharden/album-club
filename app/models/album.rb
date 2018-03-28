class Album < ActiveRecord::Base
  has_many :tracks
  accepts_nested_attributes_for :tracks, allow_destroy: true
  default_scope :order => 'played_on DESC'
end
