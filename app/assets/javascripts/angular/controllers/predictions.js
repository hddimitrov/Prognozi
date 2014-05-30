angular.module('pro').controller('predictions', ['$scope', 'predictionServices', function($scope, predictionServices) {
 predictionServices.loadLast16().then(function(response){
    $scope.last_16 = response;
  });

  $scope.quarter_f = {};
  $scope.semi_f = {};
  $scope.finalists = {};
  $scope.champion = {};

  $scope.set_group_winner = function(group, team_id, team_name) {
    $scope.last_16.winners[group] = {id: team_id, name: team_name};
  };

  $scope.set_group_runner_up = function(group, team_id, team_name) {
    $scope.last_16.runners_up[group] = {id: team_id, name: team_name};
  };

  $scope.go_through_qf = function(ef, team_id, team_name) {
    $scope.quarter_f[ef] = {id: team_id, name: team_name};
  };

  $scope.go_through_sf = function(qf, team_id, team_name) {
    $scope.semi_f[qf] = {id: team_id, name: team_name};
  };

  $scope.go_through_f = function(sf, team_id, team_name) {
    $scope.finalists[sf] = {id: team_id, name: team_name};
  };

  $scope.win = function(team_id, team_name) {
    $scope.champion = {id: team_id, name: team_name};
  };
}]);
