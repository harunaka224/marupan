class Post < ApplicationRecord

  belongs_to :end_user
  has_many :likes, dependent: :destroy

  has_one_attached :image

  def get_image
    (image.attached?) ? image: 'no_image.png'
  end
  
  #ログイン中のユーザーがその投稿に対していいねをしているか
  def likes?(end_user)
    likes.where(end_user_id: end_user.id).exists?
  end

end
