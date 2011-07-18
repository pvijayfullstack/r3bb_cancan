class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :results, :dependent => :destroy
  validates_presence_of :name, :value
end
