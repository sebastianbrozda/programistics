class UpdateUserEmail
  include Interactor

  def perform
    user.email = email
    if user.save
      context[:message] = "Email has been changed to: #{email}"
      return
    end
    fail!(message: "Email #{email} is not valid")
  end
end
