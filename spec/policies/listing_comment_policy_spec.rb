require 'rails_helper'

describe ListingCommentPolicy do
  let(:author) { double(User, id: 100) }
  let(:private_note) { double(Note, id: 1, private?: true, user: author) }
  let(:not_private_note) { double(Note, id: 1, private?: false, user: author) }
  let(:user) { double(User, id: 1) }

  context "when user is NOT logged in" do
    it "fails when note is private" do
      expect(Note).to receive(:find_by_id).with(private_note.id) { private_note }

      policy = ListingCommentPolicy.perform({user: nil, note_id: private_note.id})

      expect(policy.allowed?).to be false
    end

    it "allows when note is not private" do
      expect(Note).to receive(:find_by_id).with(not_private_note.id) { not_private_note }

      policy = ListingCommentPolicy.perform({user: nil, note_id: not_private_note.id})

      expect(policy.allowed?).to be true
    end
  end

  context "when user is logged in" do
    it "fails when note is private and it doesn't belongs to user" do
      expect(user).to receive(:author?).with(private_note.id) { false }

      expect(Note).to receive(:find_by_id).with(private_note.id) { private_note }

      policy = ListingCommentPolicy.perform({user: user, note_id: private_note.id})

      expect(policy.allowed?).to be false
    end

    it "allows when note is private and user is author" do
      expect(user).to receive(:author?).with(private_note.id) { true }

      expect(Note).to receive(:find_by_id).with(private_note.id) { private_note }

      policy = ListingCommentPolicy.perform({user: user, note_id: private_note.id})

      expect(policy.allowed?).to be true
    end
  end


end