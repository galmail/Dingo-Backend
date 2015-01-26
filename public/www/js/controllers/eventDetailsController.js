/**
 * Event Details controller.
 *
 */

dingo.controllers.controller('EventDetailsCtrl', function($scope,$location,$stateParams,Event,Ticket) {

	$scope.event = {};
	$scope.tickets = [];

	// run on init
	(function(){
		console.log('Running EventDetailsCtrl...');
		// loading event
		var eventId = $stateParams.eventId;
		Event.getById(eventId,function(event){
			$scope.event = event;
		});
		Ticket.getByEventId(eventId,function(tickets){
			$scope.tickets = tickets;
		});
		


		// for(var i=0;i<20;i++){
		// 	$scope.tickets.push({
		// 		id: i+1,
		// 		name: 'Ticket ' + (i+1),
		// 		photo: 'http://s3-us-west-2.amazonaws.com/dingoapp-test/events/photos/057/899/f5-/tiny_pic/Xmas-K.jpg?1416413614'
		// 	});
		// };

	})();





	

	$scope.go = function(path) {
	  $location.path(path);
	};


});
