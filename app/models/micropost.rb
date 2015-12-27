class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  # returns microposts with most recent ones first, at the top 
  # mount_uploader :picture, PictureUploader
  # enables picture uploading for a new micropost
  validates :user_id, presence: true
  validates :content, presence: true,
                      length: { maximum: 140 }  
  private

end
