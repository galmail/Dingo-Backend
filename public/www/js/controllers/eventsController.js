/**
 * Events controller.
 *
 */

dingo.controllers.controller('EventsCtrl', function($scope) {

	$scope.eventsA = [];
	$scope.eventsB = [];

	for(var i=0;i<5;i++){
		$scope.eventsA.push({
			id: i+1,
			name: 'Xmas Jumper Night',
			photo: 'http://s3-us-west-2.amazonaws.com/dingoapp-test/events/photos/057/899/f5-/tiny_pic/Xmas-K.jpg?1416413614',
			address: '19 Downham Road, N15BF',
			time: '18:30',
			min_price: 15,
			num_tickets_available: 2
		});
	};

	for(var i=0;i<10;i++){
		$scope.eventsB.push({
			id: i+1,
			name: 'Xmas Jumper Night',
			photo: 'http://s3-us-west-2.amazonaws.com/dingoapp-test/events/photos/057/899/f5-/tiny_pic/Xmas-K.jpg?1416413614',
			address: '19 Downham Road, N15BF',
			time: '18:30',
			min_price: 15,
			num_tickets_available: 2
		});
	};

});
