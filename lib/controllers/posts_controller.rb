class PostsController < ActionController::Base
  before_filter :setup_forum_and_topic

  def new
    @post = ForumPost.new
  end

  def create
    params[:forum_post].merge! :user_id => current_user.id

    @topic.posts.create! params[:forum_post]

    redirect_to forum_topic_path(@forum, @topic)
  end

  private
  def setup_forum_and_topic
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:topic_id])
  end
end