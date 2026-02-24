class MessagesController < ApplicationController
    SYSTEM_PROMPT = <<-PROMPT
      You are an experienced programming teacher.
      I am a student at the Le Wagon AI Software Development bootcamp, learning how to code.
      Help me break down my problem into small, actionable steps, without giving any code at all.
      Provide step-by-step advice in Markdown.
    PROMPT

  def create
    @chat = current_user.chats.find(params[:chat_id])
    @challenge = @chat.challenge

    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    # 1. Create the user's message
    if @message.save
      response = chat_response
      # 5. Create the assistant's message
      Message.create(role: 'assistant', chat: @chat, content: response.content)
      redirect_to chat_path(@chat)
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def chat_response
    # 2. Create the RubyLLM chat
    @ruby_llm = RubyLLM.chat
    # 4. Give the system prompt and context to the chat
    @ruby_llm.with_instructions("#{SYSTEM_PROMPT}\n#{challenge_context}")
    # 5. Ask the question of the user
    return @ruby_llm.ask(@message.content)
  end

  def challenge_context
    "Here is the context of the challenge: #{@challenge.content}."
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
