require 'rails_helper'

describe WebClient do
  it 'gets response' do
    wc = WebClient.new
    expect { wc.get_response('http://google.com') }.not_to raise_error
  end
end