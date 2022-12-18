class Public::SearchesController < ApplicationController
  before_action :authenticate_end_user!

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == "end_user"
      @records = EndUser.search_for(@content,@method).page(params[:page]).per(9)
    else
      @records = Post.search_for(@content,@method).page(params[:page]).per(9)
    end
  end
end

