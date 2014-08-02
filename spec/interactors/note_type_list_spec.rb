require 'rails_helper'

describe NoteTypeList do

  it 'returns list of note types' do
    expect(NoteType).to receive(:all).once { [double(NoteType), double(NoteType)] }
    expect(NoteTypeList.perform.types.size).to eq(2)
  end
end