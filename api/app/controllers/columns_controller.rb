class ColumnsController < ApplicationController
  before_action :set_board, only: [:index, :create]
  before_action :set_column, only: [:show, :update, :destroy]

  # GET /columns
  def index
    @columns = @board.columns

    render json: @columns, **serializer_options
  end

  # GET /columns/1
  def show
    render json: @column
  end

  # POST /columns
  def create
    @column = @board.columns.new(column_params)

    if @column.save
      render json: @column, status: :created, location: @column
    else
      render json: @column.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /columns/1
  def update
    if @column.update(column_params)
      render json: @column
    else
      render json: @column.errors, status: :unprocessable_entity
    end
  end

  # DELETE /columns/1
  def destroy
    @column.destroy
  end

  private
    def set_board
      @board=Board.find(params[:board_id])
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_column
      @column = Column.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def column_params
      params.require(:column).permit(:name, :title, :position)
    end

    def serializer_options
      { nested: params.key?(:nested) }
    end
end
