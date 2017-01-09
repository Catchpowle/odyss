class NotificationMailer < ApplicationMailer
  def new_membership(recipient, new_member, group)
    data = {
      template_id: "new-membership",
      substitution_data: {
        group_id: group.id,
        group: group.name,
        recipient: recipient.name,
        new_member: new_member.name
      }
    }

    mail(to: recipient.email, sparkpost_data: data) do |format|
      format.text { render text: "" }
    end
  end

  def test_membership
    data = {
      template_id: "test_one",
      substitution_data: {
        recipient: "Jonathan Catchpowle"
      }
    }

    mail(to: "jonathan.catchpowle@gmail.com", sparkpost_data: data) do |format|
      format.text { render text: "" }
    end
  end
end
