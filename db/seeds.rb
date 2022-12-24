# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者のメールアドレスの初期設定
Admin.create!(
  email: "admin@admin",
  password: "adminadmin"
  )

users = EndUser.create!(
  [
    {email: 'tarou@test.com', name: '太郎', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpeg"),filename:"sample-user1.jpeg")},
    {email: 'hanako@test.com', name: 'はなこ', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpeg"),filename:"sample-user2.jpeg")},
    {email: 'huyuko@test.com', name: '冬子', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpeg"),filename:"sample-user3.jpeg")}
  ]
)

Post.create!(
  [
    {image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpeg"),filename:"sample-post1.jpeg"),title: "梅しそドックパン", body: "食べたかった人気パンget！", shop_name: "sakura-bakery", end_user_id: users[0].id},
    {image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpeg"),filename:"sample-post2.jpeg"),title: "チーズとハムのホットサンド", body: "海沿いで景色もよし", shop_name: "Surf-Cafe", end_user_id: users[0].id},
    {image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpeg"),filename:"sample-post3.jpeg"),title: "バタークロワッサン", body: "美味しすぎた。奥にカフェもあり", shop_name: "くもぱん", end_user_id: users[1].id},
    {image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post4.jpeg"),filename:"sample-post4.jpeg"),title: "アールグレイチョコ", body: "紅茶好きはハマる", shop_name: "24pain", end_user_id: users[1].id},
    {image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post5.jpeg"),filename:"sample-post5.jpeg"),title: "生ハムサンド", body: "自家製生ハム入り", shop_name: "九州くん煙工房", end_user_id: users[2].id},
    {image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post6.jpeg"),filename:"sample-post6.jpeg"),title: "クロックムッシュ", body: "目玉焼きのパンに入ってるソースが美味しかった", shop_name: "ブランジュリームッシュ", end_user_id: users[2].id}
  ]
)

