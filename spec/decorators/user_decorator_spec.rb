require 'rails_helper'

describe UserDecorator do

  def decorate(user)
    UserDecorator.decorate user
  end
end