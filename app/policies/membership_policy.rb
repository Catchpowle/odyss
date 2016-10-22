class MembershipPolicy < ApplicationPolicy
  def create?
    user.groups.exclude?(record.group)
  end

  def destroy?
    return true if user.eql?(record.user)

    user.can_manage_user?(record.user, record.group)
  end
end
