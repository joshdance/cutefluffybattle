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

require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
