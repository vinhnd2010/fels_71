class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @words = Word.learned current_user
      @activities = current_user.activities.order(created_at: :DESC)
        .paginate page: params[:page], per_page: Settings.paginate_per_page
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def help
  end

  def about
  end
end
