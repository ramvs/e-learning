require "opentok"
class RoomsController < ApplicationController
  before_filter :config_opentok,:except => [:index]
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
    @@opentok_token = OpenTokService.new(@new_room).generate_token

    respond_to do |format|
      if @new_room.save
        format.html {redirect_to("/party/"+@new_room.id.to_s) }
      else
        format.html { render 'new'}
      end
    end
  end

  def party
    @apiKey = Rails.application.secrets.open_tok_API_key
    @user_name = current_user.email
    @tok_token = @@opentok_token
  end

  private
  def config_opentok
    if @opentok.nil?
      @opentok = OpenTok::OpenTok.new Rails.application.secrets.open_tok_API_key, Rails.application.secrets.open_tok_API_secret
    end
  end

  private
    def current_room
      @room = Room.find(params[:id])
    end


end
