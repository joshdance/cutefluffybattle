# == Schema Information
#
# Table name: players
#
#  id                 :integer          not null, primary key
#  name               :string
#  wins               :integer
#  matches            :integer
#  win_percentage     :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  user_id            :integer
#  flagged            :boolean
#  flagged_by_user_id :integer
#

class Player < ActiveRecord::Base

	after_initialize :init

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"] #paperclip requires
	validates :image, presence: true
    validates :name, presence: true


	belongs_to :user

    after_create :send_notification
	
	def init
      self.win_percentage ||= 0.0  #will set the default value only if it's nil
    end

  	def send_notification
  		#instance method so pass in self which is current user, deliver_now or deliver_later
  		AdminMailer.new_player(self).deliver_now
  	end #end send_notification
end
