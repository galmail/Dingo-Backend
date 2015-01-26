/**
 * Ticket Details controller.
 *
 */

dingo.controllers.controller('TicketDetailsCtrl', function($scope,$stateParams,Event,Ticket) {

	$scope.event = {};
	$scope.ticket = {};

	// run on init
	(function(){
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

	})();

});
