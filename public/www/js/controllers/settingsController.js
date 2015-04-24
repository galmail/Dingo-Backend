/**
 * Settings controller.
 *
 */

dingo.controllers.controller('SettingsCtrl', function($scope, $location, User, Facebook) {

	$scope.user_data = {};

	$scope.saveSettings = function(){
		User.updateProfile($scope.user_data,function(ok){
			if(ok){
				alert('Settings saved successfully!');
			}
			else {
				alert('Settings were not saved. Please check your connection and try again.');
			}
		});
	};

	$scope.logout = function(){
		User.logout();
		$location.path('/');
	};

  // Connect with facebook
  $scope.connectWithFacebook = function(){

    var FBApi = null;
    var FBLogin = null;

    if(window.facebookConnectPlugin){
      FBLogin = function(callback,error){
        var array_permissions = ['public_profile,email'];
        return facebookConnectPlugin.login(array_permissions,callback,error);
      };
      FBApi = function(requestPath,callback,error){
        var array_permissions = [];
        return facebookConnectPlugin.api(requestPath, array_permissions, callback, error);
      };
    }
    else {
      FBLogin = function(callback){
        return Facebook.login(callback,{scope: 'public_profile,email'});
      };
      FBApi = function(requestPath,callback,error){
        var method = 'get';
        var params = null;
        return Facebook.api(requestPath, method, params, callback);
      };
    }

    
    FBLogin(
      function (response){
        console.log('user is connected with facebook!');
        FBApi("me/",
          function (response){
            var userData = User.fbParseUserInfo(response);
            User.setInfo(userData);
            User.connect(function(ok){
              if(ok){
                alert('User is logged in!');
              }
              else {
                alert('User is not logged in!');
              }
            });
          }
        );
      },
      function (response){
        //alert(JSON.stringify(response))
        alert('User is not connected with facebook!');
      }
    );
    
    
  };














  var init = function(){
    console.log('Running Settings Controller...');
    $scope.user_data = User.getInfo();
  };


  // run on init for every controller
  (function(){
    if(User.isLogged()) init(); else User.registerToLoginCallback(init);
  })();

  
});
