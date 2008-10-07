class ForumsController < ActionController::Base
  helper ForumHelper
  include ForumHelper

  def index
    @forums = Forum.all
  end

  def show
    @forum = Forum.find(params[:id])
    @topics = @forum.topics.paginate :page => params[:page]
  end
end
