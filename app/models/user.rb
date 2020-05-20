class User < ApplicationRecord
  has_many :parties_host, class_name: :parties
  has_many :parties_guest, source: :parties, through: :invitations
end
