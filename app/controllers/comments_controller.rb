class CommentsController < ApplicationController

  
   def create
      @commentable = find_commentable
      @comment = @commentable.comments.build(comment_params.merge user_id: session[:user_id])
      @comment.save
      # This is equals to Movie.(value)

      # Last line can also be replaced by
      # @comment = @commentable.comments.create(comment_params) 
      
      # The line above is equals to this:
      # commentable = find_commentable
      # comment = Coment.new comment_params
      # comment.save
      # commentable.comments << comment
      # commentable.save

         if @comment.save
            flash[:notice] = "Successfully saved comment."
            redirect_to :back
         else
         render :action => 'new'
         end
   end

   def find_commentable
      params.each do |name, value|
         if name =~ /(.+)_id$/
            return $1.classify.constantize.find(value)
            # This is equals to Movie.find(value)
         end
      end
   nil
   end


   def comment_params
      params.require(:comment).permit(:content)
   end


   def destroy
      comment = Comment.find(params[:id])
      comment.destroy
      redirect_to :back
   end



end
