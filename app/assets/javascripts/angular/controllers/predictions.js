angular.module('pro').controller('predictions', ['$scope', 'predictionServices', function($scope, predictionServices) {
 predictionServices.loadKnockoutStage().then(function(response){
    $scope.last_16 = response;
  });

  $scope.quarter_f = {};
  $scope.semi_f = {};
  $scope.finalists = {};
  $scope.champion = {};

  $scope.set_group_winner = function(group, team_id, team_name) {
    $scope.last_16.winners[group] = {team_id: team_id, team_name: team_name};
  };

  $scope.set_group_runner_up = function(group, team_id, team_name) {
    $scope.last_16.runners_up[group] = {team_id: team_id, team_name: team_name};
  };

  $scope.go_through_qf = function(ef, team_id, team_name) {
    $scope.quarter_f[ef] = {team_id: team_id, team_name: team_name};
  };

  $scope.go_through_sf = function(qf, team_id, team_name) {
    $scope.semi_f[qf] = {team_id: team_id, team_name: team_name};
  };

  $scope.go_through_f = function(sf, team_id, team_name) {
    $scope.finalists[sf] = {team_id: team_id, team_name: team_name};
  };

  $scope.win = function(team_id, team_name) {
    $scope.champion = {team_id: team_id, team_name: team_name};
  };

  $scope.clear_knockout_stage = function() {
    $scope.quarter_f = {};
    $scope.semi_f = {};
    $scope.finalists = {};
    $scope.champion = {};
  };

  $scope.save_knockout_stage = function() {
    var qf = [], sf = [], f = [], c = [];
    angular.forEach($scope.quarter_f, function(value, key) {
      qf.push(value.team_id);
    });
    angular.forEach($scope.semi_f, function(value, key) {
      sf.push(value.team_id);
     });
    angular.forEach($scope.finalists, function(value, key) {
      f.push(value.team_id);
     });
    predictionServices.saveKnockoutStage(qf.toString(), sf.toString(), f.toString(), $scope.champion.team_id);
  };
}]);
