# == Schema Information
#
# Table name: notes
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  body             :text
#  short_body       :text
#  user_id          :integer
#  note_type_id     :integer
#  comment_count    :integer          default(0)
#  price_for_access :decimal(8, 2)    default(0.0)
#  decimal          :decimal(8, 2)    default(0.0)
#  created_at       :datetime
#  updated_at       :datetime
#

class Note < ActiveRecord::Base
  acts_as_taggable
  acts_as_commentable

  belongs_to :user
  belongs_to :note_type
  has_many :favorite_notes

  before_save :reload_comment_count

  validates :title, :presence => true, :length => {:minimum => 3}
  validates :body, :presence => true, :length => {:minimum => 3}
  validates :note_type_id, :presence => true
  validates :user_id, :presence => true

  scope :for_all_users, -> { where("note_type_id IN(?)", [NoteType::TYPE_PUBLIC, NoteType::TYPE_PAID_ACCESS]) }

  delegate :user_name, to: :user, prefix: false, allow_nil: false
  delegate :name, to: :note_type, prefix: true, allow_nil: false

  def to_param
    "#{title.parameterize},#{id}"
  end

  def private?
    note_type_id == NoteType::TYPE_PRIVATE
  end

  def public?
    note_type_id == NoteType::TYPE_PUBLIC
  end

  def paid_access?
    note_type_id == NoteType::TYPE_PAID_ACCESS
  end

  def new_comment
    comments.new
  end

  private
  def reload_comment_count
    self.comment_count = comments.count
  end
end
