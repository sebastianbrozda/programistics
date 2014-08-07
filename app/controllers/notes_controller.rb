class NotesController < ApplicationController
  before_action :load_note_types, except: [:show, :my_own]
  policy(:has_login, except: [:show, :purchase]) { {user: current_user} }

  def new
    @note = Note.new
  end

  def create
    create_note = CreateNote.perform({note_params: note_params, user: current_user, tags: params[:tags]})
    @note = create_note.note

    if create_note.success?
      redirect_to note_path(@note), notice: "Note has been created."
    else
      render new_note_path
    end
  end

  def show
    @note = NoteDecorator.decorate(ReturnNoteBySlugAndId.perform({id: params[:id]}).note)
  end

  def my_own
    show_all_my_own_notes = ShowAllMyOwnNotes.perform({user: current_user})
    @notes = NoteDecorator.decorate_collection show_all_my_own_notes.notes
  end

  def unauthorized(message)
    redirect_to new_user_session_path, alert: message
  end

  private
  def note_params
    params.require(:note).permit(:title, :body, :short_body, :note_type_id, :price_for_access)
  end

  def load_note_types
    @note_types = NoteTypeList.perform.types
  end
end
