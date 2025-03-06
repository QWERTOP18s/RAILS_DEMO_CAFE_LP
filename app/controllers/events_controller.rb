class EventsController < ApplicationController
  before_action :set_event, only: [:update, :destroy]

  def create
    @event = Event.new(event_params)
    if @event.save
      respond_to do |format|
        format.html { redirect_to @event, flash: { success: I18n.t('events.create.success') } }
        format.js
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      respond_to do |format|
        format.html { redirect_to @event, flash: { success: I18n.t('events.update.success') } }
        format.js
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    # #{root_path}#news ではなくroot_pathにリダイレクトしてしまう。
    redirect_to "#{root_path}#news", flash: { success: I18n.t('events.destroy.success') }
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :date)
  end
end
