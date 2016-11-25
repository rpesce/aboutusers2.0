class ArticlesController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index, :show]
	before_action :require_user, except: [:index, :show]

	def index
		@articles = Article.paginate(page: params[:page], per_page: 5).order('created_at DESC')
		respond_to do |format|
  			format.html
  			format.js
		end
	end

	def show
		@article = Article.find(params[:id])
	end

	def new	
	  @article = Article.new	
	end

	def edit
		@article = Article.find(params[:id])
	end

	def create
		@article = Article.new(article_params)
		@article.user = current_user

		if @article.save
			flash[:success] = "Article successfully created"
			redirect_to root_path
		else
			render 'new'
		end
	end

	def update
		@article = Article.find(params[:id])
 
  		if @article.update(article_params)
  			flash[:success] = "Article successfully updated!"
    		redirect_to root_path
  		else
    		render 'edit'
  		end
	end

	def destroy
		@article = Article.find(params[:id])
  		@article.destroy
  		flash[:danger] = "The article was successfully deleted"
 
  		redirect_to root_path
	end

	private
		def article_params
				params.require(:article).permit(:title, :text, :medium)
		end

		 def require_user
    		authenticate_user!
  		end


end
