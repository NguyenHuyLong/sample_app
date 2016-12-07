class Micropost < ActiveRecord::Base
  belongs_to :user

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  validate :picture_size

  scope :order_by_created_at, -> {order created_at: :desc}
  scope :feeds, -> id {where("user_id IN
    (SELECT followed_id FROM relationships WHERE follower_id = :user_id)
    OR user_id = :user_id", user_id: id)}

  private
  def picture_size
    if picture.size > 5.megabytes
      errors.add :picture, "should be less than 5MB"
    end
  end
end
