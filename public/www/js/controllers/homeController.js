/**
 * Home controller.
 *
 */

dingo.controllers.controller('HomeCtrl', function($scope, $http, $location, User, Push) {

	$scope.num_unread_messages = '';

	// run on init
	(function(){
		console.log('Running Home Controller...');

		if(!User.isLogged()){
			if(localStorage.getItem('email')!=null && localStorage.getItem('auth_token')!=null){
				// login in the background
				User.setInfo({
					email: localStorage.getItem('email'),
					auth_token: localStorage.getItem('auth_token')
				});
				User.login(function(ok){
					if(ok){
						$scope.num_unread_messages = User.getInfo().num_unread_messages;
						// register device
						setTimeout(function(){ Push.register(); }, 3000);
					}
				});
			}
			else {
				$location.path("/app/login");
			}
		}
		else {
			$scope.num_unread_messages = User.getInfo().num_unread_messages;
		}

		User.registerToNewMessagesCallback(function(){
			$scope.num_unread_messages = User.getInfo().num_unread_messages;
		});

	})();
  
});
