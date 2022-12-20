module Public::NotificationsHelper

  def notification_form(notification)
    @visiter = notification.visiter
    @post_comment = nil
    @visiter_post_comment = notification.post_comment_id
    #notification.actionがlikeかpostcommentか
    case notification.action
      when "like" then
       tag.a(notification.visiter.name, href:end_user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:post_path(notification.post_id), style:"font-weight: bold;")+"にいいねしました"
      when "comment" then
      	@post_comment = PostComment.find_by(id: @visiter_post_comment)&.comment
      	tag.a(@visiter.name, href:end_user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:post_path(notification.post_id), style:"font-weight: bold;")+"にコメントしました"
    end
  end
  
  def unchecked_notifications
    @notifications = current_end_user.passive_notifications.where(checked: false)
  end
end
