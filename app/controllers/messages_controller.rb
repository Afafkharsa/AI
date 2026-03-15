class MessagesController < ApplicationController
  before_action :authenticate_user!

  SYSTEM_PROMPT = <<~PROMPT
    You are a recipe assistant, helping users find and create recipes.

    I am a user looking to discover new recipes, get cooking instructions and track my calories.

    Help me find, suggest and create recipes. Always structure your recipe with:
    - Name
    - Ingredients with quantities
    - Step by step method
    - Total calories
    - Allergens

    Always respond **strictly in JSON** without any extra text or markdown.
    The JSON must include these keys:

    {
      "name": string,              # Recipe name
      "ingredients": [             # List of ingredients
        {"ingredient": string, "quantity": string}
      ],
      "method": [string],          # Step-by-step instructions
      "keywords": [string],        # Tags like 'high protein', 'vegan'
      "calories": integer,         # Total calories
      "allergens": [string]        # e.g., "dairy", "nuts", empty array if none
    }

    Rules:

    1. Never include markdown fences (```), explanations, or any text outside the JSON.
    2. Use arrays for ingredients and method.
    3. Always include all keys even if some values are empty (e.g., "allergens": []).
    4. Make keywords relevant to the recipe.
    5. Ensure ingredient quantities are included.
    6. Always return **valid JSON** ready to parse.

    Example output:

    {
      "name": "High-Protein Greek Yogurt Chicken Salad",
      "ingredients": [
        {"ingredient": "cooked chicken breast", "quantity": "150 g"},
        {"ingredient": "plain Greek yogurt", "quantity": "120 g"},
        {"ingredient": "celery", "quantity": "50 g"}
      ],
      "method": [
        "Mix the chicken with Greek yogurt and celery.",
        "Season with salt and pepper."
      ],
      "keywords": ["high protein", "low carb", "quick meal"],
      "calories": 310,
      "allergens": ["dairy"]
    }

    Be concise, structured, and precise.
  PROMPT

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
