class CatsController < ActionController::Base

    def index
        cats = Cat.all
        render :index
    end

    def show
        @cat = Cat.find_by(id: params[:id])
        if !@cat.nil?
            render :show
        else
            render json: ["cat not found"]
        end
    end

    def new
        @cat = Cat.new
        render :new
    end

    def edit
        @cat = Cat.find(params[:id])
        render :edit
    end

    def update
        @cat = Cat.find_by(id: params[:id])
        if @cat && @cat.update(cat_params)
            redirect_to cat_url(@cat.id)
        else
            render json: @cat.errors.full_messages, status: 422
        end
    end

    def create 
        @cat = Cat.new(cat_params)

        if @cat.save
            redirect_to cat_url(@cat.id)
        else
            render json: @cat.errors.full_messages, status: 422
        end
    end

    private
    def cat_params
        params.require(:cats).permit(:birth_date, :color, :name, :sex, :description)
    end
end
