/**
 * Auth controller.
 *
 */

dingo.controllers.controller('AuthCtrl', function($scope, $ionicModal, $timeout, $http, User) {

  $scope.fbLogin = function(){
    if (window.cordova && window.cordova.platformId == "browser"){
      var fbAppId = "667287336672842";
      console.log('initiating facebook sdk, fbAppId=' + fbAppId);
      facebookConnectPlugin.browserInit(fbAppId);
    }
    facebookConnectPlugin.login(["email"],
      function (response){
        console.log('user is connected with facebook!');
        facebookConnectPlugin.api( "me/", ["user_birthday"],
          function (response){
            var userData = User.fbParseUserInfo(response);
            User.setInfo(userData);
            User.connect(function(ok){
              if(ok){
                alert('user is logged in!');
              }
              else {
                alert('user is not logged in!');
              }
            });
          }
        );
      },
      function (response){
        //alert(JSON.stringify(response))
        alert('user is not connected with facebook!');
      }
    );
  }

  $scope.guestLogin = function(){
    console.log('guest login!');
    var uuid = device.uuid;
    if(uuid == null){
      var guid = (function() {
        function s4() {
          return Math.floor((1 + Math.random()) * 0x10000)
                     .toString(16)
                     .substring(1);
        }
        return function() {
          return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
                 s4() + '-' + s4() + s4() + s4();
        };
      })();
      uuid = guid();
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