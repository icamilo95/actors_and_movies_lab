class CommentsController < ApplicationController

  
   def create
      @commentable = find_commentable
      @comment = @commentable.comments.build(comment_params)
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
