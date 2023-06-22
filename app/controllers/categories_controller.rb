class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def index
    @categories = Category.all
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
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
