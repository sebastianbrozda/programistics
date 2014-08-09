require 'rails_helper'

describe CommentDecorator do
  def decorate(comment)
    CommentDecorator.decorate comment
  end

  describe '#created_at' do
    it 'generates formatted date' do
      comment = decorate double(Comment, created_at: Time.parse("2001-02-03 11:22:33"))
      expect(comment.created_at).to eq "2001-02-03 11:22:33"
    end
  end

  describe '#comment_body' do
    it 'returns comment body' do
      comment = decorate(double(Comment, comment: double('comment', comment: 'comment body')))
      expect(comment.comment_body).to eq 'comment body'
    end
  end
end