class MembershipPolicy < ApplicationPolicy
  def create?
    debugger
    user.groups.exclude?(record.group)
  end

  def destroy?
    user.groups.include?(record.group)
  end
end
