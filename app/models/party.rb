class Party < ApplicationRecord
  belongs_to :user
  has_many :invitations
  has_many :guests, through: :invitations, source: :user
  scope :upcoming_parties, -> { where("end_time > ?", DateTime.now)}
  scope :past_parties, -> { where("end_time < ?", DateTime.now)}

  def guest_list
    guests.join(", ")
  end

  def guest_list=(guests_string)
    guest_usernames = guests_string.split(",").collect{|s| s.strip.downcase}.uniq
    user_ids = User.select(:id).where(username: guest_usernames).map(&:id)
    p user_ids
    new_or_found_invitations = user_ids.collect do |id|
      Invitation.find_or_create_by(user_id: id)
    end
    self.invitations = new_or_found_invitations
  end
end
