/**
 * Auth controller.
 *
 */

dingo.controllers.controller('AuthCtrl', function($scope, Facebook, $ionicModal, $timeout, $http, User, Util, Config) {

  // Login with facebook
  $scope.fbLogin = function(){

    var FBApi = null;
    var FBLogin = null;

    // if (window.cordova && window.cordova.platformId == "browser"){
    //   var fbAppId = Config.FacebookAppId;
    //   console.log('initiating facebook sdk, fbAppId=' + fbAppId);
    //   facebookConnectPlugin.browserInit(fbAppId);
    // }

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
    
    
  }

  // Login as Guest
  $scope.guestLogin = function(){
    if (User.isLogged()){
      alert('User is already logged!');
      return;
    }

    var uuid = null;

    if(window.device && window.device.uuid){
      uuid = device.uuid;
    }
    else {
      uuid = Util.generateUUID();
    }
    User.setInfo({ email: uuid+'@guest.dingoapp.co.uk', password: '123456789', name: 'Guest'});
    User.connect(function(ok){
      if(ok){
        alert('user is logged in!');
      }
      else {
        alert('user is not logged in!');
      }
    });
  }

    
}); 