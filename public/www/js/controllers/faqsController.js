/**
 * FAQs controller.
 *
 */

dingo.controllers.controller('FAQsCtrl', function($scope) {

	$scope.groups = [
		{
			name: "What is Dingo all about?",
			item: "<p>Dingo is a marketplace for buying and selling tickets to live events.</p><p>Whether you need to sell your ticket at the last minute or are looking to buy a ticket to a sold out show we've got you covered!</p><p>Dingo allows you to meet, chat and transact with other fans in just a few taps.</p>"
		},
		{
			name: "How do I sell my ticket?",
			item: "<p>Selling your tickets with Dingo is easy. Either click on the Sell Tickets button at the bottom of the homescreen and search for your event or click the Sell Tickets button on the event page itself. From there, fill out the required information, add a photo of your ticket(s) and confirm your listing. All your tickets can be viewed and edited in the My Tickets section.</p><p>If you cannot find your event, fill in all the required information and we will add your tickets once verified.</p><p>We have designed Dingo to be effortlessly simple. If you think we could improve our user experience, we would love to hear from you at info@dingoapp.co.uk.</p>"
		},
		{
			name: "Why should I sell my ticket with Dingo?",
			item: "<p><b>Easy:</b> Dingo is a mobile app designed for on-the-go simplicity and convenience. Listing a ticket has never been easier. Dingo is perfect for those last-minute situations.</p><p><b>Cheap:</b> Pay no fees or commission to sell your ticket.</p><p><b>Flexible:</b> With Dingo you are in charge. Chat with potential buyers within the app and arrange delivery or collection in person, whatever works for you.</p>"
		},
		{
			name: "Why can’t I sell my ticket above face value?",
			item: "<p>Dingo is a service for fans by fans. We think the secondary ticket market in the UK is a murky world rife with touts, fraud and inflated prices. Dingo aims to change the secondary market for good, starting with face value tickets and secured transactions.</p>"
		},
		{
			name: "How do the payments work?",
			item: "<p>We are committed to making the secondary ticket market more transparent. Unfortunately there are people who make a lot of money selling fake tickets to unknowing fans. To protect buyers we release the money to the seller 48 hours after the event so the tickets can be verified.</p><p>Buyers have 48 hours to report any problems. After this we cannot help!</p>"
		},
		{
			name: "How does the fraud guarentee work?",
			item: "<p>In the unlikely event that your tickets are not genuine, Dingo will refund 100% of the cost. You MUST make a claim within 48 hours after the event takes place. Claims after this time cannot be heard.</p><p>If you have any problems with your tickets please get in touch ASAP at info@dingoapp.co.uk.</p>"
		},
		{
			name: "Is Dingo safe?",
			item: "<p>Safety and security is our key priority. We have taken the following steps to ensure that Dingo is a safe place to buy and sell tickets:</p><p><b>Delayed Payments:</b> Buyers pay Dingo directly, and we hold the money for 48 hours after the event. If no challenge is made within this 48 hour period the funds are released to the seller.</p><p><b>Payment security:</b> All transactions through Dingo are powered by PayPal and Stripe. Your sensitive card details are protected and secured by these providers, they will not be stored on your device or on our servers. For more information about PayPal and Stripe please visit their websites.</p><p><b>Facebook Verification:</b> To buy or sell on Dingo all users must login through Facebook. Profile pictures and first names are displayed to other users in order to create a trusted community.</p><p><b>Community Management:</b> The Dingo team will block the accounts and devices of known fraudulent users. We encourage you to report users acting suspiciously or fraudulently on the app via report@dingoapp.co.uk.</p><p><b>User Ratings:</b> We will be integrating user ratings soon.</p>"
		},
		{
			name: "How do the fees work?",
			item: "<p>Dingo is a transparent marketplace.</p><p>There is no fee for listing tickets for sale.</p><p>For any transactions made through the app, we charge the buyer a 10% commission. This commission covers all PayPal and transaction fees, our fraud guarantee and our dispute resolution service.</p>"
		},
		{
			name: "Is selling my ticket legal?",
			item: "<p>Under UK law, two types of ticket are illegal for resale by an unauthorised individual. These are 1) UK train tickets and 2) Professional football tickets (including premier league and FA Cup competition tickets).</p>"
		}
	];
  
  /*
   * if given group is the selected group, deselect it
   * else, select the given group
   */
  $scope.toggleGroup = function(group) {
    if ($scope.isGroupShown(group)) {
      $scope.shownGroup = null;
    } else {
      $scope.shownGroup = group;
    }
  };
  $scope.isGroupShown = function(group) {
    return $scope.shownGroup === group;
  };

	// run on init
	(function(){
		console.log('Running FAQs Controller...');
		
	})();



  
});
