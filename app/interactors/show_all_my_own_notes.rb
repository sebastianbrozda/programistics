class ShowAllMyOwnNotes
  include Interactor

  def perform
    context[:notes] = Note.where(user_id: user.id)
  end
end
