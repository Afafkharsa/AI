class MessagesController < ApplicationController
  before_action :authenticate_user!

  SYSTEM_PROMPT = "
    You are a recipe assistant, helping users find and create recipes.

    I am a user looking to discover new recipes, get cooking instructions and track my calories.

    Help me find, suggest and create recipes. Always structure your recipe with:
    - Name
    - Ingredients with quantities
    - Step by step method
    - Total calories
    - Allergens

    Answer in json with following keys :
     - name,
     - ingredients,
     - method,
     - keywords,
     - calories,
     - allergens.
    For exemple high protein is a keyword
  "

  def create
    @chat = current_user.chats.find(params[:chat_id])

    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.save
      ruby_llm_chat = RubyLLM.chat(model: "gpt-4o")
      response = ruby_llm_chat.with_instructions(SYSTEM_PROMPT).ask(@message.content)
      Message.create(role: "assistant", content: response.content, chat: @chat)
      @chat.generate_title_from_first_message
      redirect_to chat_path(@chat)
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
