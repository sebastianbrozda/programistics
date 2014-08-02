class HasLoginPolicy
  include Policy::PolicyObject

  def perform
    fail!(message: "Please log in first") unless user
  end
end