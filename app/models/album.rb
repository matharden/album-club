class Album < ActiveRecord::Base
  default_scope :order => 'played_on DESC'
end
