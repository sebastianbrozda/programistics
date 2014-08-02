class ChainNotFoundError < StandardError
end
class FeeNotFoundError < StandardError
end

class BlockExplorerParser
  def initialize(transaction_hash, web_client)
    @transaction_hash = transaction_hash
    @web_client = web_client
  end

  def parse
    @response = get_response

    if @response.code != 200
      raise ChainNotFoundError
    end
  end

  def transaction_fee
    fee_match = @response.body.match TRANSACTION_FEE_PATTERN
    if fee_match
      return fee_match[1].to_f
    end

    raise FeeNotFoundError
  end

  private
  def get_response
    @web_client.get_response url
  end

  TRANSACTION_FEE_PATTERN = "Fee\s*<sup>\s*<a.*>\?</a></sup>\:\s*([\-|\.|0-9]+)\s*</li>"

  def url
    @url ||= "http://blockexplorer.com/tx/#{p.transaction_hash}"
  end
end