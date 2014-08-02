require 'rails_helper'

describe BlockExplorerParser do

  let(:response_body) do
    '<li>Fee<sup><a href="/nojshelp/The+amount+of+BTC+given+to+the+person+who+generated+the+block+this+appeared+in.+It%27s+the+difference+between+total+BTC+in+and+total+BTC+out."title="The amount of BTC given to the person who generated the block this appeared in. It\'s the difference between total BTC in and total BTC out." onClick="informHelp();return false" class="help">?</a></sup>: 0.0002</li>'
  end

  let(:block_parser) do
    BlockExplorerParser.new 'hash', double('web_client')
  end

  it "returns code status 404 if chain doesn't exist yet" do
    expect(block_parser).to receive(:get_response) { double('HTTPResponse', code: 404) }
    expect { block_parser.parse }.to raise_error ChainNotFoundError
  end

  it "returns transaction fee if chain exists" do
    expect(block_parser).to receive(:get_response) { double('HTTPResponse', code: 200, body: response_body) }
    block_parser.parse
    expect(block_parser.transaction_fee).to eq 0.0002
  end

  it "raises error when found no fee" do
    expect(block_parser).to receive(:get_response) { double('HTTPResponse', code: 200, body: 'error') }
    block_parser.parse
    expect { block_parser.transaction_fee }.to raise_error FeeNotFoundError
  end
end