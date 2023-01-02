class EventsController < ApplicationController
  def index
    @events = Event.where(user: current_user)
  end

  def show
    @event = Event.find(params[:id])
  end

  def present
    @event = Event.find(params[:event_id])
    @list = who_gets_who
    # @list.each do |key, value|
    #   target = "#{value.first_name} #{value.last_name}"
    #   EventMailer.secret_santa_confirmation(key, target).deliver_now
    # end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      Participant.create(first_name: current_user.first_name,
                         last_name: current_user.last_name,
                         email: current_user.email,
                         event: @event)
      redirect_to events_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :max_amount)
  end

  def who_gets_who
    couples = mixing_participants
    good_choice = check_the_same(couples)
    until good_choice
      couples = mixing_participants
      good_choice = check_the_same(couples)
    end
    participants = Event.find(params[:event_id]).participants
    pairs = {}
    couples.each do |key, value|
      pairs[participants[key]] = participants[value]
    end
    return pairs
  end

  def mixing_participants
    event = Event.find(params[:event_id])
    numbers = (0...event.participants.length).to_a
    couples = {}
    numbers_shuffle = numbers.shuffle
    numbers.each_with_index do |number, index|
      couples[number] = numbers_shuffle[index]
    end
    return couples
  end

  def check_the_same(couples)
    return true if couples.length <= 1

    couples.each do |key, value|
      return false if key == value
    end
    return true
  end
end
