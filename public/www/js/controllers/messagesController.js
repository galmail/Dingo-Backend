/**
 * Messages controller.
 *
 */

dingo.controllers.controller('MessagesCtrl', function($scope,$stateParams,$ionicScrollDelegate,Message,User) {

	$scope.messages = [];
	$scope.peers = [];
	$scope.current_user_id = null;
	$scope.active_peer = null;
	$scope.message_to_send = { txt: '' };

	$scope.setActivePeer = function(peer){
		Message.active_peer = peer;
	};

	$scope.sendMessage = function(){
		if($scope.message_to_send.txt=='') return;
		Message.sendMessage($scope.message_to_send.txt,function(){
			$scope.message_to_send.txt = '';
			var conversationId = $stateParams.conversationId;
			Message.loadChat(conversationId,function(messages){
				$scope.messages = messages;
				$ionicScrollDelegate.$getByHandle('chatScroll').scrollBottom();
			});
		});
	};


	var init = function(){
		console.log('Running Messages Controller...');
		$scope.current_user_id = User.getInfo().id;
		var conversationId = $stateParams.conversationId;
		if(conversationId){
			// set active peer
			$scope.active_peer = Message.active_peer;
			// get conversation
			Message.loadChat(conversationId,function(messages){
				$scope.messages = messages;
				setTimeout(function(){ $ionicScrollDelegate.$getByHandle('chatScroll').scrollBottom(); }, 200);
			});
		}
		else {
			// get peers
			Message.getPeers(function(peers){
				$scope.peers = peers;
			});
		}
	};


	// run on init for every controller
	(function(){
		if(User.isLogged()) init(); else User.registerToLoginCallback(init);
	})();


});
