class EventNotifier < ActionMailer::Base
  default :from => "\"Dingo Team\" <#{Settings.DINGO_EMAIL}>"

  def dingo_email
    "\"Dingo Team\" <#{Settings.DINGO_EMAIL}>"
  end
  
  # report new event created to Dingo
  def report_new_event_to_dingo(the_event)
    @event = the_event
    mail(:from => self.dingo_email,:to => Settings.DINGO_EMAIL,:subject => 'A New Event Has Been Created')
  end
  
end