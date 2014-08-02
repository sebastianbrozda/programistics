class NotesForAllUsers
  include Interactor

  def perform
    context[:notes] = Note.for_all_users
  end
end
