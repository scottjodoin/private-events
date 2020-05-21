class Party < ApplicationRecord
  belongs_to :user
  has_many :invitations, dependent: :destroy
  has_many :guests, through: :invitations, source: :user
  scope :upcoming_parties, -> { where("end_time > ?", DateTime.now)}
  scope :past_parties, -> { where("end_time < ?", DateTime.now)}

  def guest_list
    guests.join(", ")
  end

  def guest_list=(guests_string)
    guest_usernames = guests_string.split(",").collect{|s| s.strip.downcase}.uniq
    guest_ids = User.select(:id).where(username: guest_usernames).map(&:id)
    new_or_found_invitations = guest_ids.collect do |guest_id|
      Invitation.find_or_create_by(user_id: guest_id, party_id: self.id) unless guest_id == self.user_id
    end
    self.invitations = new_or_found_invitations.compact
  end
end
