class DeletePostsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    while true
      Comment.where(['created_at < ?', 24.hours.ago]).destroy_all
      Tag.where(['created_at < ?', 24.hours.ago]).destroy_all
      Post.where(['created_at < ?', 24.hours.ago]).destroy_all
      sleep 1800
    end
  end
end
