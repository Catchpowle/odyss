class GroupPolicy < ApplicationPolicy
  def new?
    user.groups.exclude?(record)
  end

  def edit?
    user.groups.include?(record)
  end

  def show?
    user
  end
end
