/**
 * Events controller.
 *
 */

dingo.controllers.controller('EventsCtrl', function($scope, Category, Event) {

	$scope.category_width = 164;
	$scope.categories = [];
	$scope.events = [];


	$scope.eventsA = [];
	$scope.eventsB = [];


	// run on init
	(function(){

		console.log('Running Events Controller...');
		
		Category.loadAll(function(categories){
			$scope.categories = categories;
			$scope.categories_width = ($scope.category_width * categories.length) - 5;
		});

		Event.loadAll(function(events){
			$scope.events = events;
		});


		

		// for(var i=0;i<5;i++){
		// 	$scope.eventsA.push({
		// 		id: i+1,
		// 		name: 'Xmas Jumper Night',
		// 		photo: 'http://lorempixel.com/70/70/nightlife/?_='+i,
		// 		address: '19 Downham Road, N15BF',
		// 		time: '18:30',
		// 		min_price: 15,
		// 		num_tickets_available: 2
		// 	});
		// };

		// for(var i=0;i<10;i++){
		// 	$scope.eventsB.push({
		// 		id: i+1,
		// 		name: 'Xmas Jumper Night',
		// 		photo: 'http://lorempixel.com/70/70/nightlife/?_='+(i+100),
		// 		address: '19 Downham Road, N15BF',
		// 		time: '18:30',
		// 		min_price: 15,
		// 		num_tickets_available: 2
		// 	});
		// };





	})();



});
