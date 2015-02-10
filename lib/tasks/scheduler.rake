desc "This task clean all past events"
task :clean_events => :environment do
  puts "****** Starting Clean Events Task ******"
  
  puts "Checking for past events..."
  past_events = Event.where(['date < ? AND active=true', DateTime.now])
  if past_events.length>0
    puts "Found #{past_events.length} past events. Setting them now as inactive..."
    past_events.update_all(:active => false)
    puts "Done. The past events are now inactive."
  end
  
  puts "****** Finished Clean Events Task ******"
end


desc "This task notify admin about the pending payment to sellers on all authorised orders after 48h"
task :notify_pending_orders => :environment do
  puts "****** Starting Release Authorised Orders Task ******"
  
  puts "Check for authorised orders on past events after 48h."
  pending_orders = Order.joins(:event).where(["orders.status = ? AND events.date < ?", 'AUTHORISED' , DateTime.now - 48.hours])
  if pending_orders.length>0
    puts "Found #{pending_orders.length} orders. Releasing payments for these orders.."
    pending_orders.each { |order|
      puts "Releasing payment for order ID: #{order.id}"
      order.release_payment
    }
    puts "Done. The payments of the authorised orders have been released."
  end
  
  puts "****** Finished Release Authorised Orders Task ******"
end
