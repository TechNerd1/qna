class QuestionsController < ApplicationController
    before_action :find_question, only: [:show, :edit, :update, :destroy]
    
    def index
        @questions = Question.all.order("created_at DESC")
    end
    
    def new 
        @question = current_user.questions.build
    end
    
    def create 
        @question = current_user.questions.build(question_params)
        if @question.save
            redirect_to question_path(@question.id)
        else
            render 'new'
        end
    end
    
    def show
       
        find_question
        
    end
    
    def update
        if @question.update(question_params)
            redirect_to question_path
        else
            render 'edit'
        end
    end
    
    def edit
        
    end
    
    def destroy
        @question.destroy
        redirect_to root_path
    end
    
    private
    
        def question_params
           params.require(:question).permit(:title) 
        end
        
        def find_question
            @question = Question.find(params[:id])
        end 
end
