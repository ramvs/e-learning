require "opentok"
class RoomsController < ApplicationController
  before_filter :current_room, :only => [:destroy,:party]
  def index
    @rooms = Room.where(public: true).order("created_at DESC")
    @new_room = Room.new
  end



  def new
  end

  def create
    params.permit!
    @new_room = Room.new(params[:room])
    opentok_token = OpenTokService.new(@new_room).generate_token
    respond_to do |format|
      if @new_room.save
        format.html {redirect_to("/party/#{@new_room.id}") }
      else
        format.html { redirect_to rooms_path , flash: {error: "Cannot create a room"}}
      end
    end
  end

  def party
    @skip_footer = true
    @apiKey = Rails.application.secrets.open_tok_API_key
    if current_user.present?
      @user_name = current_user.email
    end

    @tok_token = opentok_token = OpenTokService.new(@room).generate_token
  end

  private
    def current_room
      @room = Room.find(params[:id])
    end


end
