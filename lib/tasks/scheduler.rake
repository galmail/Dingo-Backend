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
  
  puts "Check for authorised orders on past events after 40h."
  pending_orders = Order.joins(:event).where(["orders.status = ? AND events.date < ?", 'AUTHORISED' , DateTime.now - 40.hours])
  if pending_orders.length>0
    puts "Found #{pending_orders.length} orders. Releasing payments for these orders.."
    pending_orders.each { |order|
      puts "Releasing payment for order ID: #{order.id}"
      order.release_payment(false)
    }
    puts "Done. The payments of the authorised orders have been released."
  end
  
  puts "****** Finished Release Authorised Orders Task ******"
end



desc "This task collect gumtree ticket sellers info"
task :collect_gumtree_sellers => :environment do
  puts "****** Starting Collect Gumtree Sellers Task ******"
  GUMTREE_URL = "http://www.gumtree.com/tickets/london"
  IMPORT_IO_API_KEY = "9d3b167ee670402fada5bf9e3719ae58b68de907cdcfd5624c62b9be5d7089272c33171a976841df3af2e3def31ac906662da1bb1c71c8a65361b7f12804358adb7a96d043b73a120af23282bb7a5731"
  require 'rest-client'
  response = RestClient.get 'http://api.import.io/store/connector/_magic', {:params => {:url => GUMTREE_URL, :_apikey => IMPORT_IO_API_KEY}}
  res = JSON.parse(response)
  res["tables"][0]["results"].each { |obj|
begin
    gt = Gumtree.find_by identification: obj["listing_link"].split('/').last
    if gt.nil?
      gt = Gumtree.new({
        :link => obj["listing_link"],
        :title => obj["listingtitle_value"],
        :description => obj["listinghide_description"],
        :price => obj["listing_price/_source"],
        :identification => obj["listing_link"].split('/').last,
        :published => obj["adposted_value"]
      })
      gt.save
    end
    
    if !gt.mail_sent
      mail_sent_ok = gt.sendmail
      gt.update_attributes(:mail_sent => mail_sent_ok)
      puts "mail_sent to id:#{gt.identification} = #{gt.mail_sent}"
      puts "sleeping for 10 seconds..."
      sleep(10)
    end
    
rescue
  # do nothing
end
  }
  puts "****** Finished Collect Gumtree Sellers Task ******"
end

desc "This task promote dingo to gumtree sellers"
task :promote_dingo_to_gumtree_sellers => :environment do
  puts "****** Starting Promote Dingo to Gumtree Sellers Task ******"
  #Step 1: run over the gumtree table and post message to every seller
  gumtrees = Gumtree.where({:mail_sent => false}).order('created_at DESC')
  gumtrees.each { |obj|
    RestClient.post("http://www.gumtree.com/reply/responsive",
    {
      :form => {
        "message" => "Hi, We've got some posible buyers for your ticket on Dingo. If you are interested, list your ticket in seconds on dingoapp.co.uk",
        "senderName" => "Dingo",
        "senderEmail" => "hi@dingoapp.co.uk",
        "advertId" => obj.identification,
        "advertClickSource" => "featured",
        "optInMarketing" => "on"
      }
    },
    :multipart => true
    ){ |response, request, result, &block|
      case response.code
      when 301
        # It worked, set sent_mail=true
        obj.sent_mail = true
        obj.save
      when 501
        # Server Error, it failed
      else
        # Do something
        response
      end
    }
  }
  puts "****** Finished Promote Dingo to Gumtree Sellers Task ******"
end
  
