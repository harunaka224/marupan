class Post < ApplicationRecord

  belongs_to :end_user
  has_many :likes, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  validates :shop_name, presence: true

  has_one_attached :image

  def get_image
    (image.attached?) ? image: 'no_image.png'
  end

  #ログイン中のユーザーがその投稿に対していいねをしているか
  def likes?(end_user)
    likes.where(end_user_id: end_user.id).exists?
  end

  #投稿タイトル検索分岐
  def self.search_for(content, method)
    if method == "perfect"
      Post.where(title: content)
    elsif method == "forward"
      Post.where("title LIKE ?", content+"%")
    elsif method == 'backward'
      Post.where("title LIKE ?", "%"+content)
    else
      Post.where("title LIKE ?", "%"+content+"%")
    end
  end

 #通知メゾット(いいね、コメント)
  def create_notification_by(current_end_user, like_post)
    notification = current_end_user.active_notifications.new(
      post_id: like_post.id,
      visited_id: like_post.end_user_id,
      action: "like"
    )
    notification.save if notification.valid?
  end

  def create_notification_comment!(current_end_user, post_comment_id, post_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = PostComment.select(:end_user_id).where(post_id: post_id).where.not(end_user_id: current_end_user.id).distinct
    temp_ids.each do |temp_id|
        save_notification_comment!(current_end_user, post_comment_id, temp_id['end_user_id'], post_id)
      end
  	# まだ誰もコメントしていない場合は、投稿者に通知を送る
  	save_notification_comment!(current_end_user, post_comment_id, end_user_id, post_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_end_user, post_comment_id, visited_id, post_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_end_user.active_notifications.new(
      post_id: post_id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
