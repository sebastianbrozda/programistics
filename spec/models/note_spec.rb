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

require 'rails_helper'

RSpec.describe Note, :type => :model do

  it "has a valid factory" do
    expect(FactoryGirl.create(:note)).to be_valid
  end

  context "validation" do

    def expect_error_on(note, field)
      note.save
      expect(note.errors).to include(field)
    end

    it "fails with a short title" do
      note = FactoryGirl.build(:note, title: "")
      expect_error_on note, :title
    end

    it "fails with a short body" do
      note = FactoryGirl.build(:note, body: "")
      expect_error_on note, :body
    end

    it "fails with no note type" do
      note = FactoryGirl.build(:note, note_type_id: nil)
      expect_error_on note, :note_type_id
    end

    it "fails with no user" do
      note = FactoryGirl.build(:note, user_id: nil)
      expect_error_on note, :user_id
    end

  end

  it "generates slug in param" do
    note = FactoryGirl.build(:note, id: 1, title: 'example title')
    expect(note.to_param).to eq("example-title,1")
  end

  it "returns only notes for all users" do
    FactoryGirl.create(:note, note_type_id: NoteType::TYPE_PUBLIC)
    FactoryGirl.create(:note, note_type_id: NoteType::TYPE_PUBLIC)
    FactoryGirl.create(:note, note_type_id: NoteType::TYPE_PRIVATE)
    FactoryGirl.create(:note, note_type_id: NoteType::TYPE_PAID_ACCESS)

    expect(Note.for_all_users.size).to eq(3)
    expect(Note.for_all_users.any? { |n| n.private? }).to be false
  end

  it "returns author user name" do
    user_name = 'user_name1'
    note = FactoryGirl.create(:note, user: FactoryGirl.create(:user, user_name: user_name))
    expect(note.user_name).to eq(user_name)
  end

  describe "#tag_list" do
    it "creates tags" do
      note = FactoryGirl.build(:note, user: FactoryGirl.create(:user))
      note.tag_list = "ruby,rails"

      note.save
      note.reload

      expect(note.tags.size).to eq(2)
    end
  end

  describe "#private?" do
    it "returns true when it is private" do
      note = Note.new note_type_id: NoteType::TYPE_PRIVATE
      expect(note.private?).to be true
    end
  end

  describe "public?" do
    it "returns true when it is public" do
      note = Note.new note_type_id: NoteType::TYPE_PUBLIC
      expect(note.public?).to be true
    end
  end

  describe "paid_access?" do
    it "returns true when it is paid access" do
      note = Note.new note_type_id: NoteType::TYPE_PAID_ACCESS
      expect(note.paid_access?).to be true
    end
  end

  describe "#create_comment" do
    let(:note) { FactoryGirl.create(:note) }
    let(:comment) do
      comment = note.create_comment
      comment.user = FactoryGirl.create(:user)
      comment.comment = Faker::Lorem.words
      comment
    end

    before do
      comment.save
      note.reload
    end

    it "creates comment" do
      expect(note.comments.size).to eq 1
    end

    it "increments comment_count" do
      expect(note.comment_count).to eq 1
    end
  end
end
