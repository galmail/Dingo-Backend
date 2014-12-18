/**
 * Category Service.
 *
 */

dingo.services.factory('Category', function($http) {
  
  return {
  	
    loadAll: function(callback){
      var categories = [
        { id: '1', name: 'Concerts', pic_url: 'http://lorempixel.com/280/200/nightlife/?_=1' },
        { id: '2', name: 'Sports', pic_url: 'http://lorempixel.com/280/200/nightlife/?_=2' },
        { id: '3', name: 'Theatre', pic_url: 'http://lorempixel.com/280/200/nightlife/?_=3' },
        { id: '4', name: 'Music', pic_url: 'http://lorempixel.com/280/200/nightlife/?_=4' }
      ];
      callback(categories);
  	}

  };

});