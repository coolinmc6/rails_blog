class ArticlesController < ApplicationController
	# index, show, new, edit, create, update, destroy => that is the typical order of these actions

	http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

	
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

	# I created this action around 5.5 of the guide.  After creating the model, I learn that I can't yet create
	## a new entry into the database, I have to use strong parameters.
	def create
		
		# First version   => @article = Article.new(params[:article])
		# Second version  => @article = Article.new(params.require(:article).permit(:title, :text))
		## ...but the second version isn't DRY so they break out it, allowing other methods to use it.

		# Third Version:
		@article = Article.new(article_params)

		# the if-else logic was added in case
		if @article.save
			redirect_to @article
		else
			# How does the "render" method work?  It said somewhere that "render" redirects the user to the new page but with the 
			## information that was previously submitted
			render 'new'
		end
	end

	def update
	  @article = Article.find(params[:id])
	 
	  if @article.update(article_params)
	    redirect_to @article
	  else
	    render 'edit'
	  end
	end


	def destroy
	  @article = Article.find(params[:id])
	  @article.destroy
	 
	  redirect_to articles_path
	end


	private

		# "the method is often made private to make sure it can't be called outside its intended context"
	  def article_params
	    params.require(:article).permit(:title, :text)
	  end
end
