require 'rails_helper'

describe NoteDecorator do
  def decorate(note)
    NoteDecorator.decorate note
  end

  context 'created_at' do
    it 'generates formatted date' do
      decorated = decorate double(Note, created_at: Time.parse("2001-02-03 11:22:33"))
      expect(decorated.created_at).to eq "2001-02-03 11:22:33"
    end
  end

  context 'short_body' do
    it "removes dot at the end" do
      decorated = decorate double(Note, short_body: "test....")
      expect(decorated.short_body).to eq "test..."
    end

    it "generates empty message if its blank" do
      decorated = decorate double(Note, short_body: "")
      expect(decorated.short_body).to eq "[empty]..."
    end

  end

end