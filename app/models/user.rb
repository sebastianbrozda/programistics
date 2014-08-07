# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  user_name              :string(50)       not null
#  bitcoin_wallet         :string(50)
#  created_at             :datetime
#  updated_at             :datetime
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: {medium: "300x300>", thumb: "100x100>"},
                    default_url: "/images/:style/missing.png",
                    size: {in: 0..2.megabytes},
                    :hash_secret => Rails.application.secrets.user_avatar_hash_secret

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates :user_name, uniqueness: true, presence: true

  has_many :notes
  has_many :favorite_notes
  has_many :favorites, through: :favorite_notes, source: :note
  has_many :purchased_notes
  has_many :purchased, through: :purchased_notes, source: :note

  # todo: move to decorator
  def favorite_note?(note_id)
    !favorite_notes.where(note_id: note_id).first.nil?
  end

  def author?(note_id)
    !notes.where(id: note_id).first.nil?
  end

  # todo: move to decorator
  def purchased?(note_id)
    !purchased_notes.where(note_id: note_id).first.nil?
  end

  def bitcoin_address
    return email if bitcoin_wallet.blank?
    bitcoin_wallet
  end
end
