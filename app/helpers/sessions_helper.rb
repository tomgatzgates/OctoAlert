module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    token = Encryptor.new.token
    user.remember!(token)

    cookies.permanent.signed[:remember_token] = token
    cookies.permanent.signed[:user_id] = user.id
  end

  def forget(user)
    user&.forget!
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user) unless logged_in?
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user&.remebered?(cookies[:remember_token])
        log_in(user)
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end
end
