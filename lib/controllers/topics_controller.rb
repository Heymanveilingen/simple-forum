class TopicsController < ActionController::Base
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
    @topic.posts.create! params[:forum_post]

    redirect_to @forum
  end

  private
  def setup_forum
    @forum = Forum.find(params[:forum_id])
  end

  helper_method :avatar_url_for
  def avatar_url_for(user, options = {})
    return "" unless user.respond_to? "email"

    url_for({ :gravatar_id => Digest::MD5.hexdigest(user.email), :host => 'www.gravatar.com',
              :protocol => 'http://', :only_path => false, :controller => 'avatar.php'
            }.merge(options))
            
  end
end