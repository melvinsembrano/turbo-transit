# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :set_channels
  before_action :set_channel
  before_action :set_message, only: %i[show edit update destroy]

  # GET /messages or /messages.json
  def index
    @messages = @channel.messages.order(created_at: :asc)
  end

  # GET /messages/1 or /messages/1.json
  def show; end

  # GET /messages/new
  def new
    @message = @channel.messages.new
  end

  # GET /messages/1/edit
  def edit; end

  # POST /messages or /messages.json
  def create
    @message = @channel.messages.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to channel_message_url(@channel, @message), notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
      format.turbo_stream
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to channel_message_url(@channel, @message), notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy

    respond_to do |format|
      format.html { redirect_to channel_messages_url(@channel), notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_channels
    @channels = Channel.all
  end

  def set_channel
    @channel = Channel.find(params[:channel_id])
  end

  def set_message
    @message = @channel.messages.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:message).permit(:body)
  end
end
