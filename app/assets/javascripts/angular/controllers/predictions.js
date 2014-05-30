angular.module('pro').controller('predictions', ['$scope', '$filter', 'predictionServices', function($scope, $filter, predictionServices) {
  $scope.last_16 = {};
  $scope.eliminations = {};
  $scope.quarter_f = {};
  $scope.semi_f = {};
  $scope.finalists = {};
  $scope.champion = {};

 predictionServices.loadKnockoutStage().then(function(response){
    $scope.last_16 = response.last_16;
    $scope.eliminations = response.eliminations;
    $scope.populateKnockoutStage();
  });

  $scope.populateKnockoutStage = function(){
    angular.forEach($scope.last_16.winners, function(value, key) {
      if(angular.isDefined(value.team_id) && $filter('getByProperty')('team_id', value.team_id, $scope.eliminations.qf) !== null){
        if(key == 'A'){
          $scope.quarter_f[49] = value;
        }
        if(key == 'B'){
          $scope.quarter_f[51] = value;
        }
        if(key == 'C'){
          $scope.quarter_f[50] = value;
        }
        if(key == 'D'){
          $scope.quarter_f[52] = value;
        }
        if(key == 'E'){
          $scope.quarter_f[53] = value;
        }
        if(key == 'F'){
          $scope.quarter_f[55] = value;
        }
        if(key == 'G'){
          $scope.quarter_f[54] = value;
        }
        if(key == 'H'){
          $scope.quarter_f[56] = value;
        }
      }
    });

    angular.forEach($scope.last_16.runners_up, function(value, key) {
      if(angular.isDefined(value.team_id) && $filter('getByProperty')('team_id', value.team_id, $scope.eliminations.qf) !== null){
        if(key == 'A'){
          $scope.quarter_f[51] = value;
        }
        if(key == 'B'){
          $scope.quarter_f[49] = value;
        }
        if(key == 'C'){
          $scope.quarter_f[52] = value;
        }
        if(key == 'D'){
          $scope.quarter_f[50] = value;
        }
        if(key == 'E'){
          $scope.quarter_f[55] = value;
        }
        if(key == 'F'){
          $scope.quarter_f[53] = value;
        }
        if(key == 'G'){
          $scope.quarter_f[56] = value;
        }
        if(key == 'H'){
          $scope.quarter_f[54] = value;
        }
      }
    });

    angular.forEach($scope.quarter_f, function(value, key) {
      if(angular.isDefined(value.team_id) && $filter('getByProperty')('team_id', value.team_id, $scope.eliminations.sf) !== null){
        if(key == 49 || key == 50){
          $scope.semi_f[57] = value;
        }
        if(key == 53 || key == 54){
          $scope.semi_f[58] = value;
        }
        if(key == 51 || key == 52){
          $scope.semi_f[59] = value;
        }
        if(key == 55 || key == 56){
          $scope.semi_f[60] = value;
        }
      }
    });

    angular.forEach($scope.semi_f, function(value, key) {
      if(angular.isDefined(value.team_id) && $filter('getByProperty')('team_id', value.team_id, $scope.eliminations.f) !== null){
        if(key == 57 || key == 58){
          $scope.finalists[61] = value;
        }
        if(key == 59 || key == 60){
          $scope.finalists[62] = value;
        }
      }
    });

    angular.forEach($scope.finalists, function(value, key) {
      if(angular.isDefined(value.team_id) && $filter('getByProperty')('team_id', value.team_id, $scope.eliminations.c) !== null){
        $scope.champion = value;
      }
    });
  };

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
