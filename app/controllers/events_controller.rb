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
    # p couples
    # p good_choice
    until good_choice
      couples = mixing_participants
      # p couples
      good_choice = check_the_same(couples)
      # p good_choice
    end
    participants = Event.find(params[:event_id]).participants
    pairs = {}
    couples.each do |key, value|
      pairs[participants[key]] = participants[value]
    end
    # event = Event.find(params[:id])
    # givers = event.participants
    # recievers = event.participants.shuffle
    # givers.each do |element|
    #   puts element.first_name
    # end
    # puts "little break"
    # recievers.each do |element|
    #   puts element.first_name
    # end
    # couples = {}
    # givers.each do |giver|
    #   reciever = recievers.sample
    #   while giver == reciever
    #     reciever = recievers.sample
    #   end
    #   couples[giver] = reciever
    # end
    # i = 1
    # couples.each do |couple|
    #   puts "couple number #{i}"
    #   puts couple[0].first_name
    #   puts couple[1].first_name
    #   i += 1
    # end
    # puts 'these are the couples for your secret santa'
    # pairs.each do |key, value|
    #   puts "#{key.first_name} must offer a present to #{value.first_name}"
    # end
    return pairs
  end

  def mixing_participants
    event = Event.find(params[:event_id])
    # p event.participants.length
    numbers = (0...event.participants.length).to_a
    # givers = event.participants
    # recievers = event.participants.shuffle
    # if givers == recievers
    #   p "it's kinda working"
    # else
    #   p "it's also maybe working"
    # end
    couples = {}
    numbers_shuffle = numbers.shuffle
    numbers.each_with_index do |number, index|
      couples[number] = numbers_shuffle[index]
    end
    return couples
  end

  def check_the_same(couples)
    # puts couples
    return true if couples.length <= 1

    couples.each do |key, value|
      return false if key == value
    end
    return true
  end
end
