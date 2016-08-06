class PicturesController < ApplicationController


	def destroy
		@picture = Picture.find(params[:id])
		@post = @picture.post
		@picture.destroy
		
		respond_to do |format|
			format.html { redirect_to @post}	
			format.js
		end
	end
end
