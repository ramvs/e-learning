class OpenTokService
  def initialize(room)
    @room = room
    @opentok = OpenTok::OpenTok.new Rails.application.secrets.open_tok_API_key, Rails.application.secrets.open_tok_API_secret
  end

  def generate_token
    create_session unless @room.sessionId.present?
    role = :moderator #or :publisher
    @opentok.generate_token @room.sessionId
  end

  def create_session
    tok_session = @opentok.create_session
    # save session_id on DB, Session never expires
    @room.update_attributes sessionId: tok_session.session_id
  end
end