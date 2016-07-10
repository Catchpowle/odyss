class GroupPolicy < ApplicationPolicy
  def new?
    user
  end

  def edit?
    user
  end

  def show?
    user
  end
end
