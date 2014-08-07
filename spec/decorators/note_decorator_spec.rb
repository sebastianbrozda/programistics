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

  describe "#tags" do
    it "generates tags" do
      decorated = decorate double(Note, tags: %w{tag1 tag2 tag3})
      expect(decorated.tags).to eq "tag1, tag2, tag3"
    end
  end

  describe "#icon" do
    it "generates document icon for public note" do
      decorated = decorate double(Note, public?: true, paid_access?: false, private?: false)
      expect(decorated.icon).to eq "icon-doc"
    end

    it "generates bitcoin icon for note with paid access" do
      decorated = decorate double(Note, public?: false, paid_access?: true, private?: false)
      expect(decorated.icon).to eq "icon-bitcoin"
    end

    it "generates lock icon for private note" do
      decorated = decorate double(Note, public?: false, paid_access?: false, private?: true)
      expect(decorated.icon).to eq "icon-lock"
    end
  end

  describe "#slug" do
    it "generates slug" do
      decorated = decorate double(Note, title: "example", id: 1)
      expect(decorated.slug).to eq decorated.to_param
    end
  end

  describe "#has_to_purchase_access?(user)" do
    context "when access to the note is free" do
      let(:note) { decorate double(Note, paid_access?: false) }

      context "and when user is not logged in" do
        it "returns false" do
          expect(note.has_to_purchase_access?(nil)).to be false
        end
      end

      context "and when user is logged in" do
        it "returns false" do
          expect(note.has_to_purchase_access?(double(User))).to be false
        end
      end
    end

    context "when access to the note is NOT free" do
      let(:note) { decorate double(Note, id: 1, paid_access?: true) }
      let(:user) { double(User, id: 10) }

      context "and user is an author" do
        it "returns false" do
          expect(user).to receive(:author?).with(note.id) { true }
          expect(note.has_to_purchase_access?(user)).to be false
        end
      end

      context "and user is NOT an author" do
        let(:author) do
          expect(user).to receive(:author?).with(note.id) { false }
          user
        end

        context "and don't has access to read it" do
          it "returns true" do
            expect(author).to receive(:purchased?).with(note.id) { false }
            expect(note.has_to_purchase_access?(author)).to be true
          end
        end

        context "and has access to read it" do
          it "returns false" do
            expect(author).to receive(:purchased?).with(note.id) { true }
            expect(note.has_to_purchase_access?(author)).to be false
          end
        end
      end

      context "and user is NOT logged in" do
        it "returns true" do
          expect(note.has_to_purchase_access?(nil)).to be true
        end
      end
    end

  end

end
