/**
 * Push Service.
 *
 */

dingo.services.factory('Push', function($http) {
	
	return {

		successHandler: function(result){
			console.log('PushService successHandler');
			console.log('result,',result);
		},

		errorHandler: function(error){
			console.log('PushService errorHandler');
			console.log('error,',error);
		},

		register: function(){
			if(!window.cordova || !window.device) return false;
			var self = this;
			self.pushNotification = window.plugins.pushNotification;
			window.onNotification = self.onNotification;
			window.onNotificationAPN = self.onNotification;
			window.registerDevice = self.registerDevice;
			console.log('Registering ' + device.platform);
			if ( device.platform == 'android' || device.platform == 'Android' || device.platform == "amazon-fireos" ){
			    self.pushNotification.register(
			    self.successHandler,
			    self.errorHandler,
			    {
			        "senderID":"536332914346", //dingoapp-001
			        "ecb":"onNotification"
			    });
			} else if ( device.platform == 'blackberry10'){
			    self.pushNotification.register(
			    self.successHandler,
			    self.errorHandler,
			    {
			        invokeTargetId : "replace_with_invoke_target_id",
			        appId: "replace_with_app_id",
			        ppgUrl:"replace_with_ppg_url", //remove for BES pushes
			        ecb: "onNotification",
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
			}
			return true;
		},

		onNotification: function(res){
			console.log('Received Push',res);
			if(res.event == 'registered'){
				window.registerDevice(res.regid,function(ok){
					console.log('Device Registered: ' + ok);
				});
				return true;
			}
			else if(res.event == 'message'){
				console.log('Push Payload',res.payload);
				alert(res.payload.alert);
				if(res.foreground){
					// got a push notification in the foreground
					console.log('Foreground Notification');
				}
				else {
					// got a push notification in the background
					if(res.coldstart){
						// the user just touched a notification
						console.log('Coldstart Notification');
					}
					else {
						console.log('Background Notification');
					}
				}
			}

			// if (res.alert)
	  //   {
	  //     navigator.notification.alert(res.alert);
	  //   }
	  //   if (res.sound)
	  //   {
	  //       var snd = new Media(res.sound);
	  //       snd.play();
	  //   }
	  //   if (res.badge)
	  //   {
	  //       this.pushNotification.setApplicationIconBadgeNumber(successHandler, errorHandler, res.badge);
	  //   }

		},

		registerDevice: function(regId, callback){
      $http.post('/api/v1/devices',{
        uid: regId,
        brand: window.device.platform,
        model: window.device.model,
        os: window.device.version,
        app_version: window.device.appVersion
      }).success(function(res){
        console.log('registerDevice success', res);
        callback(true);
      }).error(function(err){
        console.log('registerDevice error', err);
        callback(false);
      });
    }


		
	};
});