class User < ApplicationRecord
  enum status: { active: 1, inactive: 0 }
  belongs_to :shop
  belongs_to :role

  def role_name
    role.name
  end
end
