class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]

  def new
    @category = Category.new
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        flash[:success] = "Category was created successfully!"
        format.html {
          redirect_to categories_path
        }
      else
        flash.now[:danger] = "There was something wrong with your input!"
        format.html {
          render(:new, status: :unprocessable_entity)
        }
      end
    end
  end

  def show
    @category = Category.find(params[:id])
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    respond_to do |format|
      if @category.update(category_params)
        flash[:success] = "Category was successfully updated!"
        format.html {
          redirect_to category_path(@category)
        }
      else
        format.html {
          render(:edit, status: :unprocessable_entity)
        }
      end
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !user_signed_in? || (user_signed_in? and !current_user.admin?)
      flash[:danger] = "Only admins can perform that action!"
      redirect_to categories_path
    end
  end
end
