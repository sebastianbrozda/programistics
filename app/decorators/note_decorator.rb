class NoteDecorator < Draper::Decorator
  decorates :note
  delegate_all

  def created_at
    object.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  def short_body
    if object.short_body.blank?
      return "[empty]..." if object.paid_access?
      return "#{remove_dots_from_the_end(object.body.split(' ').take(15).join(' '))}..."
    end

    "#{remove_dots_from_the_end(object.short_body)}..."
  end

  private
  def remove_dots_from_the_end(text)
    text.gsub(/\.*$/, '')
  end

end
