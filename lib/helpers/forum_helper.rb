module ForumHelper
  def forum_session
    @forum_session ||= ForumSession.new(session)
  end

  def moderator_actions_for(forum, &block)
    if forum.moderators.include? current_user
      yield
    end
  end

  def last_post_info(object)
    s = []
    s << object.last_post_at.strftime("%d-%m-%Y %H:%M") if object.last_post_at
    s << "por" if object.last_post_by
    s << link_to(h(object.last_poster.name), object.last_poster) if object.last_poster
    s * "&nbsp;"
  end

  def avatar_url_for(user, options = {})
    return "" unless user.respond_to? "email"

    %(http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}.jpg?s=#{options[:size] || 80})
  end
end
