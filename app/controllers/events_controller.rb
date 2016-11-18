class EventsController < ApplicationController 
  before_action :set_event, only: [:show, :edit, :upadte, :destroy]

  def index
    @events = Event.where(start: params[:start]..params[:end])
  end

  def show
    
  end

  def new
    @event = Event.new
  end
  
  def edit
    
  end

  def create
    @event = Event.new(event_params)
    @event.save
  end

  def update
    @event.update(event_params)
  end

  def destory
    @event.destory
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :date_range, :start, :end, :color)
    end
end