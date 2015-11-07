class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # user tableにカラム name を追加したので、devise gem のデータ入力用の
  # strong parameterを、変更する記述を書く。
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # sign_up 時に、 name カラムへのデータ入力を可能にする。
    devise_parameter_sanitizer.for(:sign_up) << :name
    # name カラムのデータを変更する際に、データ入力を可能にする。
    devise_parameter_sanitizer.for(:account_update) << :name
  end
end
