class ForumPost < ActiveRecord::Base
  validates_presence_of :body
  validates_presence_of :user_id

  belongs_to :topic, :class_name => "ForumTopic"
  belongs_to :user

  def self.per_page
    10
  end

  def after_create
    topic.last_post_by = user_id
    topic.last_post_at = created_at
    topic.save(false)
  end
end
