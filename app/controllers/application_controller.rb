class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    Post.where(guest_id: guest_id).update_all(is_guest: false, user_id: resource.id, guest_id: nil)
    super
  end

  def guest_id
    cookies.permanent[:guest_id] ||= Post.new_guest_id
  end
end