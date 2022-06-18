class RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    room = Room.create
    current_entry = Entry.create(user_id: current_user.id, room_id: room.id)
    another_entry = Entry.create(user_id: params[:entry][:user_id], room_id: room.id)
    redirect_to room_path(room)
    logger.debug another_entry.errors.inspect
  end

  def index
    current_entries = current_user.entries
    my_rooom_id = []
    current_entries.each do |entry|
      my_rooom_id << entry.room.id
    end
    @another_entries = Entry.where(room_id: my_rooom_id).where.not(user_id: current_user.id)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.all
    @message = Message.new
    @entries = @room.entries
    @another_entry = @entries.where.not(user_id: current_user.id).first
  end
end
