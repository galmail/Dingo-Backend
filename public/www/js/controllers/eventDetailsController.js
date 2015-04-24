/**
 * Event Details controller.
 *
 */

dingo.controllers.controller('EventDetailsCtrl', function($scope,$location,$stateParams,Event,Ticket,User) {

	$scope.event = {};
	$scope.tickets = [];

	$scope.go = function(path) {
	  $location.path(path);
	};

	var init = function(){
		console.log('Running EventDetailsCtrl...');
		// loading event
		var eventId = $stateParams.eventId;
		Event.getById(eventId,function(event){
			$scope.event = event;
		});
		Ticket.getByEventId(eventId,function(tickets){
			$scope.tickets = tickets;
		});
	};



	// run on init for every controller
	(function(){
		if(User.isLogged()) init(); else User.registerToLoginCallback(init);
	})();

});
