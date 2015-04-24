/**
 * Order Service.
 *
 */

dingo.services.factory('Order', function($http, Util) {

  return {

    order: {},

    saveOrder: function(ticketDetails,callback){
      var self = this;
      //ticketDetails.order_paid = true;
      //ticketDetails.paypal_key = payment.response.id;
      $http.post('/api/v1/orders',ticketDetails).success(function(res){
        self.order = res;
        callback();
      });
    },

    approveOrder: function(payment,callback){
      var self = this;
      $http.post('/api/v1/paypal/success',{
        order_id: self.order.id,
        paypal_key: payment.response.id
      }).success(callback);
    },

    rejectOrder: function(callback){
      var self = this;
      $http.post('/api/v1/paypal/cancel',{
        order_id: self.order.id
      }).success(callback);
    }

  };

});