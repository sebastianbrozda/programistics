require 'rails_helper'

describe CreateComment do
  let(:note) { FactoryGirl.build(:note) }
  let(:user) { FactoryGirl.build(:user) }

  context "when comment is valid" do
    it "creates comment" do
      expect(note).to receive(:create_comment) do
        comment = Comment.new
        expect(comment).to receive(:save) { true }
        comment
      end
      expect(Note).to receive(:find_by_id).with(note.id) { note }


      expect(CommentValidator).to receive(:new) do
        double(CommentValidator, valid?: true)
      end

      comment_body = "comment body"

      create_comment = CreateComment.perform({note_id: note.id,
                                              user_id: user.id,
                                              comment_body: comment_body})

      expect(create_comment.success?).to be true
      expect(create_comment.comment.user_id).to eq user.id
      expect(create_comment.comment.comment).to eq comment_body
      expect(create_comment.message).not_to be_blank
    end
  end

  context "and comment is invalid" do
    it "returns message error" do

      expect(note).to receive(:create_comment) do
        comment = Comment.new
        expect(comment).to receive(:errors).twice { double('full_messages', full_messages: []) }
        comment
      end

      expect(Note).to receive(:find_by_id).with(note.id) { note }

      expect(CommentValidator).to receive(:new) do
        double(CommentValidator, valid?: false,
               errors: double('full_messages', full_messages: ['error1']))
      end

      create_comment = CreateComment.perform({note_id: note.id,
                                              user_id: user.id,
                                              comment_body: ''})

      expect(create_comment.success?).to be false
      expect(create_comment.message).not_to be_blank
    end
  end
end