class Player < ActiveRecord::Base

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"] #paperclip requires
	validates :image, presence: true
    validates :name, presence: true


	belongs_to :user
	
end
