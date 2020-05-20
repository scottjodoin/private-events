class Party < ApplicationRecord
  belongs_to :host, class_type: :user
  has_many :guests, through: :invitations
end
