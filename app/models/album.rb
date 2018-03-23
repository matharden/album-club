class Album < ActiveRecord::Base
  has_many :tracks
  default_scope :order => 'played_on DESC'
end
