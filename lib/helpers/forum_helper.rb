module ForumHelper
  def forum_session
    @forum_session ||= ForumSession.new(session)
  end

  def moderator_actions_for(forum, &block)
    if forum.moderators.include? current_user
      yield
    end
  end
end
