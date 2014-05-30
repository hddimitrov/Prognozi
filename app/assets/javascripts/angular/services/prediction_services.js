var prediction_services = {};
var prediction_services = angular.module('prediction_services', []);

prediction_services.factory('predictionServices', ['$http', function($http) {
  var predictionServices = {
    loadLast16: function() {
      var promise = $http.get('/knockout/last16').then(function (response) {
        return response.data;
      });

      return promise;
    }
  };

  return predictionServices;
}]);
