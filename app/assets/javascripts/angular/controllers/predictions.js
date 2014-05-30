angular.module('pro').controller('predictions', ['$scope', 'predictionServices', function($scope, predictionServices) {
 predictionServices.loadLast16().then(function(response){
    $scope.last_16 = response;
  });

  $scope.set_group_winner = function(group, team_id, team_name) {
    $scope.last_16.winners[group] = {id: team_id, name: team_name};
  };

  $scope.set_group_runner_up = function(group, team_id, team_name) {
    $scope.last_16.runners_up[group] = {id: team_id, name: team_name};
  };
}]);
