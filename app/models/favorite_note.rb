# == Schema Information
#
# Table name: favorite_notes
#
#  id      :integer          not null, primary key
#  user_id :integer
#  note_id :integer
#

class FavoriteNote < ActiveRecord::Base
  belongs_to :user
  belongs_to :note
end
