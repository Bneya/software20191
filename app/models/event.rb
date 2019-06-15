class Event < ApplicationRecord
  has_many :eventposts, dependent: :destroy

  belongs_to :classroom
  belongs_to :user

  validates_presence_of :title, :description, :classroom_id, :schedule, :day, :event_type, :user_id, :max_users, :price

  validates :max_users, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 100 }

  validates :price, :numericality => { :greater_than_or_equal_to => 0}

  validates_uniqueness_of :schedule, scope: [:day, :classroom_id]


  # probando línea
  # has_and_belongs_to_many :users
end
