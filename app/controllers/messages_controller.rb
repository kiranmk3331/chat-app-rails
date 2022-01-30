class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params.merge(user_id: current_user.id))
    if @message.save
      redirect_to root_path
    else
      flash[:errors] = @message.errors.full_messages.to_sentence
    end
  end

  private
    def message_params
      params.require(:message).permit(:body)
    end
end
