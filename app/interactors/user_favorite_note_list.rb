class UserFavoriteNoteList
  include Interactor

  def perform
    context[:notes] = user.favorites.select { |note| note.public? || note.paid_access? || user.author?(note.id) }
  end
end
