/**
 * Payment Service.
 *
 */

dingo.services.factory('Payment', function() {

  return {

    init: function(){
      // Initiating Paypal SDK
      if(window.PayPalMobile){
        var clientIDs = {
          "PayPalEnvironmentProduction": "AYMqghD3IhKeJXOLh3siE-ImJftpSQLRRWebOHlDUCN7x_i5nWDB7V3zHnC5",
          "PayPalEnvironmentSandbox": "AYuyqBCZYRwnOGI6k7DPlkgltTCEoX8m4b8XHZFqqQb0SAJLsx__gPpfnsyy"
        };
        PayPalMobile.init(clientIDs, this.onPayPalMobileInit);
      }
    },

    onPayPalMobileInit: function(){
      var self = this;
      var config = new PayPalConfiguration({
        merchantName: "Allington Ventures Ltd",
        merchantPrivacyPolicyURL: "http://dingoapp.bitnamiapp.com/web/privacy-policy/",
        merchantUserAgreementURL: "http://dingoapp.bitnamiapp.com/web/terms-conditions/",
        acceptCreditCards: false
      });
      //config.acceptCreditCards(false);

      // use PayPalEnvironmentNoNetwork mode to get look and feel of the flow
      PayPalMobile.prepareToRender("PayPalEnvironmentSandbox", config, function(){
        console.log('Paypal Library Loaded!');
      });
    },

    makePayment: function(payment,onSuccesfulPayment,onUserCanceled){
      // PayPalPaymentDetails(subtotal, shipping, tax)
      var paymentDetails = new PayPalPaymentDetails(payment.amount, "0.00", "0.00");
      // PayPalPayment(amount, currency, shortDescription, intent, details) {
      var payment = new PayPalPayment(payment.amount, "GBP", payment.description, "Sale", paymentDetails);
      // create payment
      PayPalMobile.renderSinglePaymentUI(payment, onSuccesfulPayment, onUserCanceled);
    }


  };

});