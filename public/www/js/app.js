// Dingo Mobile Web App

var dingo = angular.module('dingo',['ionic','facebook','dingo.controllers','dingo.services','dingo.directives']);
dingo.controllers = angular.module('dingo.controllers', []);
dingo.services = angular.module('dingo.services', []);
dingo.directives = angular.module('dingo.directives', []);

dingo.run(function($ionicPlatform,Payment) {
  $ionicPlatform.ready(function() {
    // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
    // for form inputs)
    if(window.cordova && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
    }
    if(window.StatusBar) {
      // org.apache.cordova.statusbar required
      StatusBar.styleDefault();
    }

    // start to initialize PayPalMobile library
    Payment.init();

    // get app version
    if(window.cordova && window.device){
      cordova.getAppVersion(function(version){
        console.log('app version is: ' + version);
        window.device.appVersion = version;
      });
    }

  });
})

.config(function ($httpProvider) {

  $httpProvider.interceptors.push(function ($q) {
       return {
           'request': function(config){
              if (window.cordova){
                if((config.url.indexOf('/api')>=0) || (config.url.indexOf('/users/')>=0)){
                  config.url = 'http://dingoapp-staging.herokuapp.com' + config.url;
                  //alert('calling: ' + config.url);
                }
              }
              return config || $q.when(config);
           }
       }
   });
})



.config(function($sceDelegateProvider) {
  $sceDelegateProvider.resourceUrlWhitelist([
    // Allow same origin resource loads.
    'self',
    // Allow loading from our assets domain.  Notice the difference between * and **.
    //'https://*.s3.amazonaws.com/**'
  ]);

  // The blacklist overrides the whitelist so the open redirect here is blocked.
  $sceDelegateProvider.resourceUrlBlacklist([
    
  ]);
})

.config(function(FacebookProvider) {
   var fbAppId = '';
   if(window.location.href.indexOf('localhost')>0){
    fbAppId = '854877257866349';
   }
   else {
    fbAppId = '672126826238840';
   }
   FacebookProvider.init(fbAppId);
})

.config(function($stateProvider, $urlRouterProvider) {
  $stateProvider

  .state('app', {
    url: "/app",
    abstract: true,
    templateUrl: "js/templates/_menu.html",
    controller: 'HomeCtrl'
  })

  ////////////////// MENU URLs ///////////////////

  .state('app.login', {
    url: "/login",
    views: {
      'menuContent' :{
        templateUrl: "js/templates/login.html",
        controller: 'AuthCtrl'
      }
    }
  })

  .state('app.settings', {
    url: "/settings",
    views: {
      'menuContent' :{
        templateUrl: "js/templates/settings.html",
        controller: 'SettingsCtrl'
      }
    }
  })

  .state('app.mytickets', {
    url: "/mytickets",
    views: {
      'menuContent' :{
        templateUrl: "js/templates/mytickets.html",
        controller: 'MyTicketsCtrl'
      }
    }
  })

  .state('app.myticketsList', {
    url: "/mytickets/:ticketsType",
    views: {
      'menuContent' :{
        templateUrl: "js/templates/myticketslist.html",
        controller: 'MyTicketsCtrl'
      }
    }
  })

  .state('app.faq', {
    url: "/faq",
    views: {
      'menuContent' :{
        templateUrl: "js/templates/faqs.html",
        controller: 'FAQsCtrl'
      }
    }
  })

  .state('app.about', {
    url: "/about",
    views: {
      'menuContent' :{
        templateUrl: "js/templates/about.html"
      }
    }
  })

  .state('app.tandcs', {
    url: "/tandcs",
    views: {
      'menuContent' :{
        templateUrl: "js/templates/tandcs.html"
      }
    }
  })

  .state('app.privacypolicy', {
    url: "/privacypolicy",
    views: {
      'menuContent' :{
        templateUrl: "js/templates/privacypolicy.html"
      }
    }
  })

  ////////////////// HOME URLs ///////////////////

  .state('home', {
    url: "/home",
    abstract: true,
    templateUrl: "js/templates/_home.html",
    controller: 'HomeCtrl'
  })

  .state('home.events', {
    url: "/events",
    views: {
      'events-tab': {
        templateUrl: "js/templates/events.html",
        controller: 'EventsCtrl'
      }
    }
  })

  .state('home.eventDetails', {
    url: "/event-details/:eventId",
    views: {
      'events-tab': {
        templateUrl: "js/templates/eventDetails.html",
        controller: 'EventDetailsCtrl'
      }
    }
  })


  .state('home.ticketDetails', {
    url: "/ticket-details/:eventId/:ticketId",
    views: {
      'events-tab': {
        templateUrl: "js/templates/ticketDetails.html",
        controller: 'TicketDetailsCtrl'
      }
    }
  })


  .state('home.sellTicket', {
    url: "/sell-ticket",
    views: {
      'sell-ticket-tab': {
        templateUrl: "js/templates/sellTicket.html",
        controller: 'SellTicketCtrl'
      }
    }
  })

  .state('home.sellTicketPreview', {
    url: "/sell-ticket-preview",
    views: {
      'sell-ticket-tab': {
        templateUrl: "js/templates/sellTicketPreview.html",
        controller: 'SellTicketCtrl'
      }
    }
  })

  .state('home.messages', {
    url: "/messages",
    views: {
      'messages-tab': {
        templateUrl: "js/templates/messages.html", //MessagesCtrl
        controller: 'MessagesCtrl'
      }
    }
  })

  .state('home.messagesChat', {
    url: "/messages/:conversationId",
    views: {
      'messages-tab': {
        templateUrl: "js/templates/messagesChat.html",
        controller: 'MessagesCtrl'
      }
    }
  })

  .state('home.search', {
    url: "/search",
    views: {
      'search-tab': {
        templateUrl: "js/templates/search.html"
      }
    }
  })
  ;

  // if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise('/home/events');

});

