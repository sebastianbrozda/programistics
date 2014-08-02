class FavoritesController < ApplicationController

  def add_note_to_favorites
    add_note_to_favorites = AddNoteToFavorites.perform({user: current_user, note_id: note_id})
    render json: {result: add_note_to_favorites.success?, msg: add_note_to_favorites.message}
  end

  def notes
    user_fav_note_list = UserFavoriteNoteList.perform({user: current_user})
    @notes = user_fav_note_list.notes
  end

  def remove_note_from_favorites
    remove_note = RemoveNoteFromFavorites.perform({user: current_user, note_id: note_id})
    render json: {result: remove_note.success?, msg: remove_note.message}
  end

  private
  def note_id
    params[:note_id].to_i
  end

end
