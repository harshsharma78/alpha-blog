class ArticlesController < ApplicationController
  # before_action will execute in the order they were called
  before_action :set_article, only: [:show, :update, :edit, :destroy]

  # Restricting access for some actions based on the login and logout state of a user
  # before_action :require_user, except: [:index, :show]
  # before_action :require_same_user, only: [:edit, :update, :destroy]

  # new and create, edit and update are dependent on each other
  def index
    # @articles = Article.all
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end
  def create
    # It will render the data in an object like form
    # render plain: params[:article].inspect

    @article = Article.new(article_params)
    # Hard-coded user_id for one-to-many-association because it is mandatory
    @article.user = current_user

    respond_to do |format|
      if @article.save
        flash[:success] = "Article was successfully created!"
        format.html {
          redirect_to article_path(@article)
        }
      else
        # NOTE: this will render `new.erb` and set
        #       `Content-Type: text/html` header;
        #       turbo is happy.
        format.html {
          render(:new, status: :unprocessable_entity)
        }
      end
    end
  end

  def edit
    # @article = Article.find(params[:id])
  end

  def update
    # @article = Article.find(params[:id])
    respond_to do |format|
      if @article.update(article_params)
        flash[:success] = "Article was successfully updated!"
        format.html {
          redirect_to article_path(@article)
        }
      else
        format.html {
          render(:edit, status: :unprocessable_entity)
        }
      end
    end
  end

  def show
    # @article = Article.find(params[:id])
  end

  def destroy
    # @article = Article.find(params[:id])
    @article.destroy
    flash[:danger] = "Article was successfully deleted!"
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  # def require_same_user
  #   if current_user != @article.user && !current_user.admin?
  #     flash[:danger] = "You can only edit or delete your own articles!"
  #     redirect_to root_path
  #   end
  # end
end
