class RecipesController < ApplicationController

    def index
        recipes = Recipe.all
        if session[:user_id]
            render json: recipes, include: :user, status: :created
        else
            render json: { errors: ["Not authorized"] }, status: :unauthorized
        end
    end

    def create
        if session[:user_id]
            user = User.find_by(id: session[:user_id])
            recipe = Recipe.new(recipe_params)
            recipe.user = user
            if recipe.valid?
                recipe.save
                render json: recipe, include: :user, status: :created
            else
                render json: { errors: ["Invalid recipe data"] }, status: :unprocessable_entity
            end
        else
            render json: { errors: ["Not authorized"] }, status: :unauthorized
        end
    end

    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end

end
