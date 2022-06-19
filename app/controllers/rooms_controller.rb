class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:show]

  def create
    room = Room.create
    current_entry = Entry.create(user_id: current_user.id, room_id: room.id)
    another_entry = Entry.create(user_id: params[:entry][:user_id], room_id: room.id)
    redirect_to room_path(room)
  end

  def index
    current_entries = current_user.entries
    my_room_id = []
    current_entries.each do |entry|
      my_room_id << entry.room.id
    end
    @another_entries = Entry.where(room_id: my_room_id).where.not(user_id: current_user.id)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.all
    @message = Message.new
    @entries = @room.entries
    @another_entry = @entries.where.not(user_id: current_user.id).first
  end

  private

  def ensure_correct_user
    @now_room = Room.find(params[:id])
    rooms = Entry.where(user_id: current_user.id,room_id: @now_room.id)
    if rooms.blank?
      redirect_to rooms_path
    else
      follow_check
    end
  end

  def follow_check
    room_partner = Entry.where(room_id: @now_room.id).where.not(user_id: current_user.id)
    partner = Relationship.where(follower_id: room_partner.select(:user_id),followed_id: current_user)
    myself = Relationship.where(follower_id: current_user,followed_id: room_partner.select(:user_id))
    if myself.blank?
      redirect_to rooms_path, notice: "FF外です"
    elsif partner.blank?
      redirect_to rooms_path, notice: "FF外です"
    end
  end
end
