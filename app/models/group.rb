class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships

  attr_accessor :start_date

  def start_date
    super.strftime('%m/%d/%Y')
  end

  def start_date=(value)
    Date.strptime(value, '%m/%d/%Y')
    super
  end
end
