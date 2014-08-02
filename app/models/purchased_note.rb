# == Schema Information
#
# Table name: purchased_notes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  note_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class PurchasedNote < ActiveRecord::Base
  belongs_to :user
  belongs_to :note
end
