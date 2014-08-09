class NoteDecorator < Draper::Decorator
  include ActionView::Helpers::TextHelper
  include Rails.application.routes.url_helpers

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

  def tags
    object.tags.map { |t| "<a href=\"#{notes_by_tag_path(t)}\">#{t}</a>" }.join(' ')
  end

  def slug
    object.to_param
  end

  def icon
    return "icon-doc" if object.public?
    return "icon-bitcoin" if object.paid_access?
    return "icon-lock" if object.private?
    "#"
  end

  def has_to_purchase_access?(user)
    return false unless paid_access?
    return true if !user
    return true if !user.author?(id) && !user.purchased?(id)
    false
  end

  private
  def remove_dots_from_the_end(text)
    text.gsub(/\.*$/, '')
  end

end
