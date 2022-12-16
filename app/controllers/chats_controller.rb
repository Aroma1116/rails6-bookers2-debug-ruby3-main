class ChatsController < ApplicationController
  before_action :rejected_non_related, only: [:show]

  def show
    #チャット相手のUser情報を取得
    @user = User.find(params[:id])
    #user_roomsテーブルのuser_idがチャットする人のレコードのroom_idをすべて取得
    rooms = current_user.user_rooms.pluck(:room_id)
    #user_idが(@user)で、room_idがチャットする人の属するroom_id（配列）となるuser_roomsテーブルのレコードを取得して、user_room変数に格納
    #これによって、チャットする人とチャット相手に共通のroom_idが存在していれば、その共通のroom_idとチャット相手のuser_idがuser_room変数に格納される（1レコード）。存在しなければ、nilになる。
    user_room = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    #user_roomにおいてroomの情報を取得できなかった場合
    room = nil
    if user_room.nil?
      room = Room.new
      room.save
      #上記で作ったroomのidを使ってチャットする人用、チャット相手それぞれのuser_roomを作成する
      UserRoom.create(user_id: @user.id, room_id: room.id)
      UserRoom.create(user_id: current_user.id, room_id: room.id)
    else
      room = user_room.room
    end

    @chats = room.chats
    @chat = Chat.new(room_id: room.id)

  end

  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
    redirect_to request.referer
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def rejected_non_related
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to user_path(user)
    end
  end

end
