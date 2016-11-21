class Membership < ActiveRecord::Base
  include PublicActivity::Model

  belongs_to :user
  belongs_to :group

  tracked
end
