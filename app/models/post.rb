class Post < ApplicationRecord

  belongs_to :end_user

  has_one_attached :image

  def get_image
    (image.attached?) ? image: 'no_image.png'
  end

end
