# == Schema Information
#
# Table name: payments
#
#  id                :integer          not null, primary key
#  user_id           :integer          not null
#  note_id           :integer          not null
#  status            :integer          not null
#  settled           :boolean          default(FALSE)
#  custom            :string(40)       not null
#  price             :decimal(12, 8)   default(0.0)
#  coinbase_order_id :string(255)
#  transaction_hash  :string(255)
#  transaction_fee   :decimal(12, 8)
#  created_at        :datetime
#  updated_at        :datetime
#

class Payment < ActiveRecord::Base
  STATUS_STARTED = 0
  STATUS_VERIFIED = 1
  STATUS_COMPLETED = 2

  belongs_to :user
  belongs_to :note

  scope :started, -> { where(status: Payment::STATUS_STARTED) }
  scope :verified, -> { where(status: Payment::STATUS_VERIFIED) }
  scope :completed, -> { where(status: Payment::STATUS_COMPLETED) }
  scope :not_settled, -> { where(settled: false) }
  scope :without_transaction_fee, -> { where(transaction_fee: nil) }
  scope :with_transaction_fee, -> { where("transaction_fee is not null") }
  scope :by_note_author_id, ->(author_id) { joins(:note).
      where("notes.user_id = :author_id", {author_id: author_id})
  }

  delegate :title, to: :note, prefix: true

  def price_in_cents
    price * 100_000_000
  end

  def completed?
    status == Payment::STATUS_COMPLETED
  end

  def complete!
    Payment.transaction do
      user.purchased << note
      self.status = Payment::STATUS_COMPLETED
      save
    end
  end

  alias_method :complete, :complete!

  def started?
    status == Payment::STATUS_STARTED
  end

  def start!(custom, user_id, note)
    self.status = Payment::STATUS_STARTED
    self.custom = custom
    self.user_id = user_id
    self.note_id = note.id
    self.settled = false
    self.price = note.price_for_access
    save
  end

  alias_method :start, :start!

end
