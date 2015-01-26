/**
 * Ticket Service.
 *
 */

dingo.services.factory('Ticket', function($http, Util) {
  
  return {

    getByEventId: function(eventId,callback){
      $http.get('/api/v1/tickets?event_id='+eventId).success(function(res){
        var tickets = res.tickets;
        callback(tickets);
      });
    },

    getById: function(ticketId,callback){
      $http.get('/api/v1/tickets?id='+ticketId).success(function(res){
        var ticket = res.tickets[0];
        callback(ticket);
      });
    }

  };

});