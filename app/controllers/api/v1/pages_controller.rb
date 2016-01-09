class Api::V1::PagesController < ApplicationController
  def show
    return render json: {error: 'missing url'}, status: 400 if params[:url].blank?

    @page = Page.find_or_create_by(url: params[:url])
    if @page.errors.any?
      render json: {error: @page.errors.full_messages}, status: 400
    else
      render json: @page
    end
  end
end
