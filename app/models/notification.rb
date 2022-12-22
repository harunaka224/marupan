class Notification < ApplicationRecord

  #常に新着順
  default_scope -> { order(created_at: :desc) }

  belongs_to :post, optional: true
  belongs_to :post_comment, optional: true
  belongs_to :visiter, class_name: 'EndUser', foreign_key: 'visiter_id', optional: true #通知を送った
  belongs_to :visited, class_name: 'EndUser', foreign_key: 'visited_id', optional: true #通知を受け取った

end
