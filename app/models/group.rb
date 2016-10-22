class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships

  validates :name, :objective, :limit, :start_date, presence: true
  validates :name, length: { maximum: 12 }
  validates :objective, length: { maximum: 80 }
  validates :information, length: { maximum: 500 }
  validates_format_of :name, with:  /\A[a-z\s]+\z/i,
                             message: 'must only contain letters and spaces'
  validates_date :start_date, on_or_after: -> { Date.current },
                              on_or_after_message: 'must be not be in the past',
                              invalid_date_message: 'must be a date'

  attr_reader :start_date

  def start_date
    super.strftime('%b %d, %Y') if super
  end

  def full?
    memberships.count.eql?(limit)
  end

  def admins
    memberships.where.not(admin: nil)
  end

  def admins?
    admins.present?
  end
end
