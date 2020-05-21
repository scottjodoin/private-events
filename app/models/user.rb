class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :parties, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :parties_guest, through: :invitations, source: :party
  def to_s
    username
  end
end
