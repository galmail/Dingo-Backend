/**
 * Home controller.
 *
 */

dingo.controllers.controller('HomeCtrl', function($scope, $ionicModal, $timeout) {


	$scope.items = [];

	for(var i = 0; i < 25; i++) {
    $scope.items.push({
      title: 'Event ' + (i + 1),
      buttons: [{
        text: 'Done',
        type: 'button-success',
        //onButtonClicked: completeItem,
      }, {
        text: 'Delete',
        type: 'button-danger',
        //onButtonClicked: removeItem,
      }]
    });
  }

  
});
