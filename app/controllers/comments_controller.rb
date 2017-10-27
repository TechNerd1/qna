class CommentsController < ApplicationController
    before_action :find_question
    before_action :find_comment, only: [:edit, :update, :destroy]
    
    def create
        @comment = @question.comments.create(comment_params)
        
        if @comment.save
            redirect_to question_path(@question)
        else
            render 'new'
        end
    end
    
    def edit
    end
    
    def update
        if @comment.update(comment_params)
            redirect_to question_path(@question)
        else
            render 'edit'
        end
    end
    
    def destroy
        @comment.destroy
        redirect_to question_path(@question)
    end
    
    private
    
        def comment_params
            params.require(:comment).permit(:content)
        end
        
        def find_question
            @question = Question.find(params[:question_id])
        end
        
        def find_comment
            @comment = @question.comments.find(params[:id])
        end
end
