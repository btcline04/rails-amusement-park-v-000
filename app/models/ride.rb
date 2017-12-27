class Ride < ActiveRecord::Base
  belongs_to :attraction
  belongs_to :user

  def take_ride
    if not_enough_tickets? && not_tall_enough?
      ticket_and_height_error_message
    elsif not_tall_enough?
      height_error_message
    elsif not_enough_tickets?
      ticket_error_message
    else
      self.user.update(tickets: self.user.tickets - self.attraction.tickets)
      self.user.update(nausea: self.user.nausea + self.attraction.nausea_rating)
      self.user.update(happiness: self.user.happiness + self.attraction.happiness_rating)
    end
  end


  def not_enough_tickets?
    self.attraction.tickets > self.user.tickets
  end

  def not_tall_enough?
    self.attraction.min_height > self.user.height 
  end

  def ticket_error_message
    "Sorry. You do not have enough tickets to ride the #{attraction.name}."
  end

  def height_error_message
    "Sorry. You are not tall enough to ride the #{attraction.name}."
  end

  def ticket_and_height_error_message
    "Sorry. You do not have enough tickets to ride the #{attraction.name}. You are not tall enough to ride the #{attraction.name}."
  end

end
