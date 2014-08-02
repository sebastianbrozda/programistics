class NoteTypeList
  include Interactor

  def perform
    context[:types] = NoteType.all
  end
end
