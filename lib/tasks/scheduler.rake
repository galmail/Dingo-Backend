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

desc "This task release payment to seller on all pending transaction after 48h"
task :release_pending_transactions => :environment do
  puts "****** Starting Release Pending Transactions Task ******"
  
  puts "Check for pending transactions on past events after 48h."
  pending_transactions = Transaction.joins(:event).where(["transactions.status = ? AND events.date < ?", :pending, DateTime.now - 48.hours])
  if pending_transactions.length>0
    puts "Found #{pending_transactions.length} transactions. Releasing payments for these transactions.."
    pending_transactions.each { |transaction|
      puts "Releasing payment for transaction ID: #{transaction.id}"
      transaction.release_payment
    }
    puts "Done. The payments of the pending transactions have been released."
  end
  
  puts "****** Finished Release Pending Transactions Task ******"
end
