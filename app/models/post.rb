class Post < ApplicationRecord

  belongs_to :end_user
  has_many :likes, dependent: :destroy
  has_many :post_comments, dependent: :destroy

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

end
