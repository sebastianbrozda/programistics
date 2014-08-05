class NoteDecorator < Draper::Decorator
  include ActionView::Helpers::TextHelper

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

  def comment_count
    return "no comments" if object.comment_count == 0
    pluralize(object.comment_count, 'comment')
  end

  private
  def remove_dots_from_the_end(text)
    text.gsub(/\.*$/, '')
  end

end
