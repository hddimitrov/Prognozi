var prediction_services = {};
var prediction_services = angular.module('prediction_services', []);

prediction_services.factory('predictionServices', ['$http', function($http) {
  var predictionServices = {

    predictMatch: function(match){
      var promise = $http.post('/match_prediction', {prediction: match}).then(function (response) {
        return response.data;
      });

      return promise;
    },
    loadGroupStage: function() {
      var promise = $http.get('/load_group_stage').then(function (response) {
        return response.data;
      });

      return promise;
    },
    saveGroupStage: function(group){
      var promise = $http.post('/group_prediction', {prediction: group}).then(function (response) {
        return response.data;
      });

      return promise;
    },
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
