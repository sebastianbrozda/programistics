# == Schema Information
#
# Table name: currencies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  price      :decimal(12, 8)
#  created_at :datetime
#  updated_at :datetime
#

class Currency < ActiveRecord::Base
end
