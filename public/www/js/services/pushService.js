/**
 * Push Service.
 *
 */

dingo.services.factory('Push', function(){
	
	return {

		register: function(){
			if(!window.cordova || !window.device) return false;
			var self = this;
			self.pushNotification = window.plugins.pushNotification;
			alert('Registering '+device.platform);
			if ( device.platform == 'android' || device.platform == 'Android' || device.platform == "amazon-fireos" ){
			    self.pushNotification.register(
			    successHandler,
			    errorHandler,
			    {
			        "senderID":"536332914346", //dingoapp-001
			        "ecb":"onNotification"
			    });
			} else if ( device.platform == 'blackberry10'){
			    self.pushNotification.register(
			    successHandler,
			    errorHandler,
			    {
			        invokeTargetId : "replace_with_invoke_target_id",
			        appId: "replace_with_app_id",
			        ppgUrl:"replace_with_ppg_url", //remove for BES pushes
			        ecb: "pushNotificationHandler",
			        simChangeCallback: replace_with_simChange_callback,
			        pushTransportReadyCallback: replace_with_pushTransportReady_callback,
			        launchApplicationOnPush: true
			    });
			} else {
					// iOS
			    self.pushNotification.register(
			    function tokenHandler (result) {
					    alert('device token = ' + result);
					},
			    function errorHandler (error) {
					    alert('error = ' + error);
					},
			    {
			        "badge":"true",
			        "sound":"true",
			        "alert":"true",
			        "ecb":"onNotificationAPN"
			    });
			    window.onNotificationAPN = self.onNotification;
			}
			return true;
		},

		onNotification: function(event){
			alert('Received Push: ' + JSON.stringify(event));
			if (event.alert)
	    {
	      navigator.notification.alert(event.alert);
	    }
	    if (event.sound)
	    {
	        var snd = new Media(event.sound);
	        snd.play();
	    }
	    if (event.badge)
	    {
	        this.pushNotification.setApplicationIconBadgeNumber(successHandler, errorHandler, event.badge);
	    }
		}


		
	};
});