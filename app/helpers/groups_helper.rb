module GroupsHelper
  def twitter_share_url(group)
    url = 'https://twitter.com/intent/tweet?'
    invite_url = group_invite_url(group)

    url << "url=#{invite_url}"
  end

  def facebook_share_url(group)
    url = 'http://www.facebook.com/sharer/sharer.php?'
    invite_url = group_invite_url(group)

    url << "u=#{invite_url}"
  end
end
