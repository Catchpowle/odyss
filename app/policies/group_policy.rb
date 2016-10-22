class GroupPolicy < ApplicationPolicy
  def new?
    user.groups.exclude?(record)
  end

  def edit?
    user.can_manage_group?(record)
  end

  def show?
    user
  end
end
