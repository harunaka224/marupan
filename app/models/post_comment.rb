class PostComment < ApplicationRecord

  belongs_to :end_user
  belongs_to :post
  has_many :notifications, dependent: :destroy
  
end
