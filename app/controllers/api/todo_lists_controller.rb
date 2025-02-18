module Api
  class TodoListsController < ApplicationController
    
    # GET /api/todolists
    def index
      @todo_lists = TodoList.all

      respond_to :json
    end

    # GET /api/todolists/1
    def show
      @todo_list = TodoList.find(params[:id])

      render json: @todo_list
    end

    # POST /api/todolists
    def create
      todo_list = TodoList.new(todo_list_params)
      if todo_list.save
        render json: todo_list, status: :created
      else
        render json: todo_list.errors, status: :unprocessable_entity
      end
    end
    
    # PUT /api/todolists/1
    def update
      @todo_list = TodoList.find(params[:id])  

      if @todo_list.update(todo_list_params)
        render json: @todo_list  
      else
        render json: { errors: @todo_list.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # DELETE /api/todolists/1
    def destroy
      @todo_list = TodoList.find_by(id: params[:id])

      if @todo_list.nil?
        render json: { error: 'Todo list not found' }, status: :ok
      else
        @todo_list.destroy
        render json: { message: 'Todo list deleted successfully' }, status: :no_content
        
      end
    end    

  private

  def ensure_json_request
    return if request.format.json?
    render json: { error: 'Not acceptable format' }, status: :not_acceptable
  end

  def todo_list_params
    params.require(:todo_list).permit(:name)
  end 
  end
end
