require 'rails_helper'

describe NoteDecorator do
  def decorate(note)
    NoteDecorator.decorate note
  end

  describe '#created_at' do
    it 'generates formatted date' do
      decorated = decorate double(Note, created_at: Time.parse("2001-02-03 11:22:33"))
      expect(decorated.created_at).to eq "2001-02-03 11:22:33"
    end
  end

  describe '#short_body' do
    it "removes dot at the end" do
      decorated = decorate double(Note, short_body: "test....", paid_access?: false)
      expect(decorated.short_body).to eq "test..."
    end

    it "generates empty message for paid access" do
      decorated = decorate double(Note, short_body: "", paid_access?: true)
      expect(decorated.short_body).to eq "[empty]..."
    end

    it "generates short body from 'body' for not paid access" do
      body = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut tempor vitae tortor a pharetra. Cras blandit nibh nec convallis ullamcorper. In eros justo, egestas a tortor nec, imperdiet eleifend sapien. Donec nisi nisl, facilisis sed mollis ac, semper nec tortor"

      decorated = decorate double(Note, short_body: "", body: body, paid_access?: false)
      expect(decorated.short_body).to eq "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut tempor vitae tortor a pharetra. Cras..."
    end
  end

  describe "#comment_count" do
    it "generates message for no comments" do
      decorated = decorate double(Note, comment_count: 0)
      expect(decorated.comment_count).to eq "no comments"
    end

    it "generates message for one comment" do
      decorated = decorate double(Note, comment_count: 1)
      expect(decorated.comment_count).to eq "1 comment"
    end

    it "generates message for comments" do
      decorated = decorate double(Note, comment_count: 2)
      expect(decorated.comment_count).to eq "2 comments"
    end
  end

end