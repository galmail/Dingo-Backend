/**
 * Events controller.
 *
 */

dingo.controllers.controller('EventsCtrl', function($scope, Category, Event, User) {

	$scope.category_width = 164;
	$scope.categories = [];
	$scope.events = [];

	var init = function(){
		console.log('Running Events Controller...');
		Category.loadAll(function(categories){
			$scope.categories = categories;
			$scope.categories_width = ($scope.category_width * categories.length) - 5;
		});
		Event.loadAll(function(events){
			$scope.events = events;
		});
	};


	// run on init for every controller
	(function(){
		if(User.isLogged()) init(); else User.registerToLoginCallback(init);
	})();



});
