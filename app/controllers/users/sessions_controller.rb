# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(_resource, _opts ={})
    already_logged_in && return if user_signed_in?

    render json: {
      message: I18n.t('devise.sessions.signed_in'),
      data: current_user
    }, status: :ok
  end

  def log_out_success
    render json: { message: I18n.t('devise.sessions.signed_out'), }, status: :ok
  end

  def log_out_failed
    render json: { message: I18n.t('devise.sessions.no_session') }, status: :unauthorized
  end

  def respond_to_on_destroy
    log_out_success && return if current_user

    log_out_failed
  end

  def already_logged_in
    render json: { message: I18n.t('devise.failure.already_authenticated') }
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
