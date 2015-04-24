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
      $http.get('/api/v1/events?any=true&name='+eventName).success(function(res){
        callback(res.events);
      });
  	}

  };

});