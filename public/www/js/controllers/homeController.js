/**
 * Home controller.
 *
 */

dingo.controllers.controller('HomeCtrl', function($scope, $http, $location, User) {

	// run on init
	(function(){
		console.log('Running Home Controller...');

		if(!User.isLogged()){
			console.log('redirecting to login page...');
			$location.path("/app/login" );
		}
		else {
			$http.defaults.headers.common = {
			  'X-User-Email': localStorage.getItem('email'),
			  'X-User-Token': localStorage.getItem('token')
			};
		}

	})();

	
  
});
