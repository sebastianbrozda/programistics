require 'rails_helper'

describe CreateCodebaseButton do

  it 'returns html button' do
    note = double(Note, id: 1, price_for_access: 10)
    expect(Note).to receive(:find_by_id).with(note.id) { note }

    coinbase = double(Coinbase::Client)
    expect(coinbase).to receive(:create_button) { double('button', embed_html: 'html') }
    expect(Coinbase::Client).to receive(:new) { coinbase }

    create_button = CreateCodebaseButton.perform({note_id: note.id, user: double(User, user_name: "user_name")})

    expect(create_button.html).not_to be_blank
  end
end