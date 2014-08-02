class CreateCodebaseButton
  include Interactor

  def perform
    @note = Note.find_by_id note_id
    button = coinbase.create_button name, price, name, custom
    context[:html] = button.embed_html
    context[:custom] = custom
  end

  private

  def coinbase
    @coinbase ||= Coinbase::Client.new(COINBASE_API_KEY, COINBASE_API_SECRET)
  end

  def name
    "access to note: #{@note.id} for #{user.user_name}"
  end

  def price
    @note.price_for_access
  end

  def custom
    @custom ||= SecureRandom.uuid
  end
end
