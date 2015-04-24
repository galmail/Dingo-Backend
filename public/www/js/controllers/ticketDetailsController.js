/**
 * Ticket Details controller.
 *
 */

dingo.controllers.controller('TicketDetailsCtrl', function($scope,$stateParams,Event,Ticket,Payment,Order,User) {

	$scope.event = {};
	$scope.ticket = {};


	$scope.buyTicket = function(){
		var self = this;
		var description = 'Ticket(s) for ' + self.event.name;

		Order.saveOrder({
			ticket_id: self.ticket.id,
			num_tickets: self.ticket.number_of_tickets,
			amount: Ticket.getTotalAmount(self.ticket)
		},function(){
			Payment.makePayment({
				amount: Ticket.getTotalToPay(self.ticket),
				description: description
			},function(payment){
				Order.approveOrder(payment,function(){
					alert("Payment Success! Redirecting now to a chat screen with the seller...");
				});
			},function(result){
				Order.rejectOrder(function(){
					alert('Payment has been canceled.');
				});
			});
		});
	};





	var init = function(){
		console.log('Running TicketDetailsCtrl...');
		// loading event and ticket details
		var eventId = $stateParams.eventId;
		var ticketId = $stateParams.ticketId;
		Event.getById(eventId,function(event){
			$scope.event = event;
		});
		Ticket.getById(ticketId,function(ticket){
			$scope.ticket = ticket;
		});
	};

	// run on init for every controller
  (function(){
    if(User.isLogged()) init(); else User.registerToLoginCallback(init);
  })();


});
