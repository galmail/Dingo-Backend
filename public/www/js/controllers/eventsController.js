/**
 * Events controller.
 *
 */

dingo.controllers.controller('EventsCtrl', function($scope, Category, Event) {

	$scope.category_width = 164;
	$scope.categories = [];
	$scope.events = [];

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

	})();



});
