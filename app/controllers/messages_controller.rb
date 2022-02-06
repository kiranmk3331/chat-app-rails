class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params.merge(user_id: current_user.id))
    if @message.save
      ActionCable.server.broadcast "chatroom_channel",
                                mod_message: message_render(@message)
    else
      flash[:errors] = @message.errors.full_messages.to_sentence
    end
  end

  private
    def message_params
      params.require(:message).permit(:body)
    end

    def message_render(message)
      render(partial: "message", locals: { message: message })
    end
end
