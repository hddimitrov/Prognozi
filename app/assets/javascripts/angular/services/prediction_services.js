var prediction_services = {};
var prediction_services = angular.module('prediction_services', []);

prediction_services.factory('predictionServices', ['$http', function($http) {
  var predictionServices = {
    group_standings: function(parameters) {
      var promise = $http.post('/api/filter/want_ads', parameters).then(function (response) {
        return response.data;
      });

      return promise;
    }
  };

  return predictionServices;
}]);
