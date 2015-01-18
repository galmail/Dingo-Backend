// Dingo Mobile Web App

var dingo = angular.module('dingo',['ionic','facebook','dingo.controllers','dingo.services','dingo.directives']);
dingo.controllers = angular.module('dingo.controllers', []);
dingo.services = angular.module('dingo.services', []);
dingo.directives = angular.module('dingo.directives', []);

dingo.run(function($ionicPlatform) {
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

// .config(function(FacebookProvider) {
//    var fbAppId = '';
//    if(window.location.href.indexOf('localhost')>0){
//     fbAppId = '854877257866349';
//    }
//    else {
//     fbAppId = '672126826238840';
//    }
//    FacebookProvider.init(fbAppId);
// })



.config(function($stateProvider, $urlRouterProvider) {
  $stateProvider

  .state('app', {
    url: "/app",
    abstract: true,
    templateUrl: "js/templates/_menu.html"
    //controller: 'HomeCtrl'
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
        templateUrl: "js/templates/settings.html"
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
    url: "/ticket-details/:ticketId",
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

  .state('home.messages', {
    url: "/messages",
    views: {
      'messages-tab': {
        templateUrl: "js/templates/messages.html"
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

