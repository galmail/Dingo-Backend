desc "This task is called by the Heroku scheduler add-on"
task :clean_events => :environment do
  puts "****** Starting Clean Events Task ******"
  
  puts "Checking for past events..."
  past_events = Event.where(['date < ?', DateTime.now])
  puts "Found #{past_events.length} past events. Setting them now as inactive..."
  past_events.update_all(:active => false)
  puts "Done. The past events are now inactive."
  
  puts "Check for pending transactions on past events between 24h and 48h."
  pending_transactions = Transaction.joins(:event).where(["transactions.status = ? AND events.date < ?", :pending, DateTime.now - 24.hours])
  
  puts "Found #{pending_transactions.length} transactions. Releasing payments for these transactions.."
  pending_transactions.each { |transaction|
    puts "Releasing payment for transaction ID: #{transaction.id}"
    transaction.release_payment
  }
  puts "Done. The payments of the pending transactions have been released."
  
  
  puts "****** Clean Events Task Finished ******"
end

# task :send_reminders => :environment do
  # User.send_reminders
# end