/**
 * User Service.
 *
 */

dingo.services.factory('User', function($http, Util) {
  
  var data = {};
  
  return {
  	
    getInfo: function(){ return data; },
  	setInfo: function(newdata){ data = newdata; },
  	
    login: function(callback){
  		var self = this;
  		$http.get('/users/sign_in',{
  			params: {
  				email: self.getInfo().email,
  				password: self.getInfo().password
  			}
  		}).success(function(res){
  			console.log('login success: ' + JSON.stringify(res));
        data.user_id = res.id;
  			// save auth_token
        $http.defaults.headers.common = {
          'X-User-Email': res.email,
          'X-User-Token': res.auth_token
        };
  			callback(true);
  		}).error(function(){
  			console.log('login error');
  			callback(false);
  		});
  	},
  	
    signup: function(callback){
  		var self = this;
  		$http.get('/users/sign_up',{
  			params: self.getInfo()
  		}).success(function(res){
  			console.log('signup success: ' + JSON.stringify(res));
  			//self.setInfo(res);
  			self.login(callback);
  		}).error(function(){
  			console.log('signup error');
  			callback(false);
  		});
  	},
  	
    connect: function(callback){
  		var self = this;
  		// try login first if fail, try to signup user
  		console.log('inside connect... trying to login first.');
  		self.login(function(ok){
  			if(ok){
  				callback(true);
  			}
  			else {
  				self.signup(callback);
  			}
  		});
  	},
  	
    fbParseUserInfo: function(params){
  		var userData = params;
  		userData.fb_id = params.id;
  		delete(userData.id);
  		if(params.birthday){
  			var bdate = params.birthday.split('/');
  			userData.birthday = bdate[1] + '/' + bdate[0] + '/' + bdate[2];
        userData.dateOfBirth = bdate[2] + '-' + bdate[0] + '-' + bdate[1];
  		}
  		userData.password = userData.fb_id;
      userData.photo_url = "http://graph.facebook.com/"+userData.fb_id+"/picture?type=large";
      if(userData.gender == 'male'){
        userData.gender = 'M';
      }
      else if(userData.gender == 'female'){
        userData.gender = 'F';
      }
  		return userData;
  	}


  };

});