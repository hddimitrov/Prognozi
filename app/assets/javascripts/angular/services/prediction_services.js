var prediction_services = {};
var prediction_services = angular.module('prediction_services', []);

prediction_services.factory('predictionServices', ['$http', function($http) {
  var predictionServices = {
    loadKnockoutStage: function() {
      var promise = $http.get('/load_knockout_stage').then(function (response) {
        return response.data;
      });

      return promise;
    },
    saveKnockoutStage: function(qf, sf, f, c) {
      var promise = $http.post('/save_knockout_stage', {qf: qf, sf: sf, f: f, c: c}).then(function (response) {
        return response.data;
      });

      return promise;
    }
  };

  return predictionServices;
}]);
