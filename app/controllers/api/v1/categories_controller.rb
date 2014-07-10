class Api::V1::CategoriesController < Api::BaseController
    
    # Get All Categories
    def index
      @categories = Category.all
    end
    
end