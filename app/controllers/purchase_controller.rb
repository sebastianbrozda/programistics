class PurchaseController < ApplicationController
  before_filter :can_purchase

  def note
    @note = selected_note

    button = CreateCodebaseButton.perform({note_id: @note.id, user: current_user})
    @button_html = button.html

    StartPayment.perform({note: @note, user: current_user, custom: button.custom})
  end

  protected
  def can_purchase
    can_purchase = CanPurchasePolicy.perform({user: current_user, note: selected_note})


    redirect_not_allowed_user(can_purchase)
  end

  def redirect_not_allowed_user(can_purchase)
    return if can_purchase.allowed?
    alert = {alert: can_purchase.message}

    case can_purchase.redirect_to
      when 'log_in'
        redirect_to new_user_session_path, alert
      when 'already_purchased'
        redirect_to note_path(selected_note), alert
      else
        raise 'redirect to error'
    end
  end

  def selected_note
    ReturnNoteBySlugAndId.perform({id: params[:id]}).note
  end

end
