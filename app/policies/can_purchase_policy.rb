class CanPurchasePolicy
  include Policy::PolicyObject

  def perform
    return redirect_to_login unless user
    return prevent_from_purchasing if user.purchased?(note.id)
  end

  private
  def redirect_to_login
    context[:redirect_to] = 'log_in'
    fail!(message: "To purchase access you have to log in first")
  end

  def prevent_from_purchasing
    context[:redirect_to] = 'already_purchased'
    fail!(message: "You already have purchased this note")
  end
end