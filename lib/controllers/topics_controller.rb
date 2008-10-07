class TopicsController < ActionController::Base
  helper ForumHelper
  include ForumHelper

  before_filter :setup_forum

  def show
    @topic = @forum.topics.find params[:id]
    @posts = @topic.posts.paginate :page => params[:page]
  end

  def new
    @topic = ForumTopic.new
  end

  def create
    params[:forum_topic].merge! :user_id => current_user.id
    params[:forum_post].merge! :user_id => current_user.id

    @topic = @forum.topics.create! params[:forum_topic]
    post = @topic.posts.create! params[:forum_post]

    forum_session.add_post(post) if post

    redirect_to @forum
  end

  private
  def setup_forum
    @forum = Forum.find(params[:forum_id])
  end

  helper_method :avatar_url_for
  def avatar_url_for(user, options = {})
    return "" unless user.respond_to? "email"

    %(http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}.jpg)
  end
end