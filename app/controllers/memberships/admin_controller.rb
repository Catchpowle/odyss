module Memberships
  class AdminController < ApplicationController
    before_action :set_membership

    def create
      @membership.update(admin: Time.zone.now)
    end

    def destroy
      @membership.update(admin: nil)
    end

    private

    def set_membership
      @membership = Membership.find(params[:membership_id])
    end
  end
end
