class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # フォロー 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visiter_id', dependent: :destroy #通知を送った
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy #通知を受け取った

  validates :name, length: { in: 2..20}, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_one_attached :profile_image

  def get_profile_image
    (profile_image.attached?) ? profile_image: 'no_end_user_image.jpg'
  end

  def self.guest
    find_or_create_by!(name: 'guest' ,email: 'guest@example.com') do |end_user|
      end_user.password = SecureRandom.urlsafe_base64
      end_user.name = "guest"
    end
  end

  # フォローしたときの処理
  def follow(end_user_id)
    relationships.create(followed_id: end_user_id)
  end
  # フォローを外すときの処理
  def unfollow(end_user_id)
    relationships.find_by(followed_id: end_user_id).destroy
  end
  # フォローしているか判定
  def following?(end_user)
    followings.include?(end_user)
  end

  #ユーザー検索分岐
  def self.search_for(content, method)
    if method == "perfect"
      EndUser.where(name: content)
    elsif method == "forward"
      EndUser.where("name LIKE ?", content+"%")
    elsif method == "backward"
      EndUser.where("name LIKE ?", "%"+content)
    else
      EndUser.where("name LIKE ?", "%"+content+"%")
    end
  end

end
