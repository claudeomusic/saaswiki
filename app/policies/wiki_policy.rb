class WikiPolicy < ApplicationPolicy

  def index?
    user.present?
  end

  def show?
    user.present? && (record.privacy == "Public" || user.premium? || user.admin?) 
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    user.present? && (user.premium?  || user.admin? || record.author_id == user._id)
  end

  def edit?
    update?
  end

  def destroy?
    user.present? && (user.admin? || record.author_id == user._id)
  end

  def add_user?
    destroy?
  end

  def remove_collaborator?
    destroy?
  end

  def private?
    user.present? && (user.premium? || user.admin?)
  end

  def shared?
    private?
  end

end