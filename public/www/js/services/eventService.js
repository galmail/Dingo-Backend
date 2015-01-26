/**
 * Event Service.
 *
 */

dingo.services.factory('Event', function($http, Util) {
  
  return {

    loadAll: function(callback){
      $http.get('/api/v1/events').success(function(res){
        // parse event date and time
        var events = res.events;
        angular.forEach(events, function(event) {
          var d = new Date(event.date);
          event.parsed_date = d.toDateString();
          event.parsed_time = d.toTimeString();
        });
        callback(events);
      });
    },

    getById: function(eventId,callback){
      $http.get('/api/v1/events?id='+eventId).success(function(res){
        var event = res.events[0];
        event.parsed_time = new Date(event.date).toTimeString();
        callback(event);
      });
    },

    searchByName: function(eventName,callback){
  		
      var myEvents = [
        { id: '1', name: 'Super Event 1', location: 'London city', from: '01/02/2015', to: '02/02/2015' },
        { id: '2', name: 'Super Event 2', location: 'London city', from: '02/02/2015', to: '03/02/2015' },
        { id: '3', name: 'Super Event 3', location: 'London city', from: '03/02/2015', to: '04/02/2015' },
        { id: '4', name: 'Super Event 4', location: 'London city', from: '04/02/2015', to: '05/02/2015' },
        { id: '5', name: 'Super Event 5', location: 'London city', from: '05/02/2015', to: '06/02/2015' },
      ];
      callback(myEvents);


    //   var self = this;
  		// $http.get('/users/sign_in',{
  		// 	params: {
  		// 		email: self.getInfo().email,
  		// 		password: self.getInfo().password
  		// 	}
  		// }).success(function(res){
  		// 	console.log('events success: ' + JSON.stringify(res));
  		// 	callback(true);
  		// }).error(function(){
  		// 	console.log('events error');
  		// 	callback(false);
  		// });



  	}

  };

});