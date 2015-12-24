class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  # enables picture uploading for a new micropost
  validates :user_id, presence: true
  validates :content, presence: true,
                      length: { maximum: 140 }
  validate :picture_size
  #note the singular 'validate'; implies a custom validation
  
  private
  
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
  
end
