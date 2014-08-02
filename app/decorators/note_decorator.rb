class NoteDecorator < Draper::Decorator
  decorates :note
  delegate_all

  def created_at
    object.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  def short_body
    return "[empty]..." if object.short_body.blank?
    "#{object.short_body.gsub(/\.*/, '')}..."
  end

end
