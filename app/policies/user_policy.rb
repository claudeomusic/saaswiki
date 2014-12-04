class UserPolicy < ApplicationPolicy

  def upgrade?
    user.present? && user.role == "standard"
  end

end