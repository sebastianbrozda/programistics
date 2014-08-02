class HomeController < ApplicationController

  def index
    @notes = NoteDecorator.decorate_collection(NotesForAllUsers.perform.notes)
  end
end
