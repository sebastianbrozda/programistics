# == Schema Information
#
# Table name: note_types
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class NoteType < ActiveRecord::Base
  TYPE_PUBLIC = 1
  TYPE_PRIVATE = 2
  TYPE_PAID_ACCESS = 3
end
