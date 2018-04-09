class Purchase < ApplicationRecord
  scope :by_user, -> (user) { where(user_id: user.id) }
  scope :provided_limit, -> (limit) { limit(limit) }
  scope :since, -> (date) { where("created_at > ?", date) }
end
