class ArticlesController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index]


	def index
		@articles = Article.all
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
		@article.user = User.first

		if @article.save
			flash[:success] = "Article successfully created"
			redirect_to @article
		else
			render 'new'
		end
	end

	def update
		@article = Article.find(params[:id])
 
  		if @article.update(article_params)
  			flash[:success] = "Article successfully updated!"
    		redirect_to @article
  		else
    		render 'edit'
  		end
	end

	def destroy
		@article = Article.find(params[:id])
  		@article.destroy
  		flash[:danger] = "The article was successfully deleted"
 
  		redirect_to articles_path
	end


	private
		def article_params
				params.require(:article).permit(:title, :text)
		end


end
