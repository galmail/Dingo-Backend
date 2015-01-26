/**
 * Category Service.
 *
 */

dingo.services.factory('Category', function($http) {
  
  return {

    loadAll: function(callback){
      $http.get('/api/v1/categories').success(function(res){
        var categories = res.categories;
        callback(categories);
      });
    }

  };

});