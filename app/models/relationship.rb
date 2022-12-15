class Relationship < ApplicationRecord
  # class_name: "EndUser"でEndUserモデルを参照
  belongs_to :follower, class_name: "EndUser"
  belongs_to :followed, class_name: "EndUser"

end
