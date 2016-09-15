class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships

  validates :name, :objective, :limit, :start_date, presence: true

  attr_reader :start_date

  def start_date
    super.strftime('%m/%d/%Y') if super
  end
end
