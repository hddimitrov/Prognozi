angular.module('pro').controller('predictions', ['$scope', '$filter', 'predictionServices', function($scope, $filter, predictionServices) {
  $scope.groups = {};
  $scope.third_placed_teams = {};
  $scope.last_16 = {};
  $scope.eliminations = {};
  $scope.quarter_f = {};
  $scope.semi_f = {};
  $scope.finalists = {};
  $scope.champion = {};

  $scope.current_group = 'A';

  predictionServices.loadGroupStage().then(function(response) {
    $scope.groups = response;
    angular.forEach($scope.groups, function(value, group_name) {
      $scope.calculateGroupStandings(group_name);
    })
  });

  predictionServices.loadKnockoutStage().then(function(response){
    $scope.last_16 = response.last_16;
    $scope.eliminations = response.eliminations;
    $scope.populateKnockoutStage();
  });

  $scope.predictMatch = function(match){
    prediction = {};
    prediction[match.id] = {host: match.host_prediction, guest: match.guest_prediction};
    predictionServices.predictMatch(prediction);
    $scope.calculateGroupStandings($scope.current_group);
  };

  $scope.calculateGroupStandings = function(group_name){
    angular.forEach($scope.groups[group_name].teams, function(team, key) {
      team.points = 0;
      team.matches_played = 0;
      team.matches_won = 0;
      team.matches_drawn = 0;
      team.matches_lost = 0;
      team.goals_for = 0;
      team.goals_against = 0;
      team.goal_difference = 0;
      team.tb = false;
    });

    angular.forEach($scope.groups[group_name].matches, function(match, key) {
      if(match.host_prediction !== null && match.guest_prediction !== null){
        host = $filter('getByProperty')('name', match.host_team, $scope.groups[group_name].teams);
        guest = $filter('getByProperty')('name', match.guest_team, $scope.groups[group_name].teams);

        if(host.name == match.host_team){
          host.matches_played += 1;
          host.goals_for += match.host_prediction;
          host.goals_against += match.guest_prediction;
          host.goal_difference += match.host_prediction;
          host.goal_difference -= match.guest_prediction;
        }
        if(guest.name == match.guest_team){
          guest.matches_played += 1;
          guest.goals_for += match.guest_prediction;
          guest.goals_against += match.host_prediction;
          guest.goal_difference += match.guest_prediction;
          guest.goal_difference -= match.host_prediction;
        }
        if(match.host_prediction == match.guest_prediction){
          host.points += 1;
          host.matches_drawn += 1;
          guest.points += 1;
          guest.matches_drawn += 1;
        }
        if(match.host_prediction > match.guest_prediction){
          host.points += 3;
          host.matches_won += 1;
          guest.matches_lost += 1;
        }
        if(match.host_prediction < match.guest_prediction){
          host.matches_lost += 1;
          guest.points += 3;
          guest.matches_won += 1;
        }
      }
    });

    teams = $filter('orderBy')($scope.groups[group_name].teams, ['-points','-goal_difference', '-goals_for', '-coef'])
    for(i=1; i <= teams.length; i++) {
      if (i == 3) {
        teams[i-1].group = group_name;
        $scope.third_placed_teams[group_name] = teams[i-1];
      }
      // teams[i].predicted_position = i+1;
      // for(j=1; j<teams.length; j++) {
      //   if(i< j && $scope.tiebreakNeeded(teams[i], teams[j])){
      //     teams[i].tb = true;
      //     teams[j].tb = true;
      //   }
      // }
    };
  };

  $scope.tiebreakNeeded = function(team1, team2){
    needed = false;
    if(team1.points == team2.points && team1.goal_difference == team2.goal_difference && team1.goals_for == team2.goals_for) {
      needed = true;
    }
    return needed;
  };

  $scope.calc3rdPlacedTeams = function() {
  };

  $scope.calculateQualifiedTeams = function(){
    // var group_standings = {};
    // angular.forEach($scope.groups, function(value, group_name){
    //   $scope.calculateGroupStandings(group_name);
    //   standings = $filter('orderBy')($scope.groups[group_name].teams, ['-points','-goal_difference', '-goals_for', '-coef']);
    //   winner = standings[0];
    //   runner_up = standings[1];
    //   third = standings[2];
    //   last = standings[3];
    //   group_standings[group_name] = {winner: winner.id, runner_up: runner_up.id, third: third.id, last: last.id};

    //   if(winner.points > 0) {
    //     $scope.last_16.winners[group_name] = {team_id: winner.id, team_name: winner.name};
    //   } else{
    //     $scope.last_16.winners[group_name] = {team_id: undefined, team_name: undefined};
    //   }
    //   if(runner_up.points > 0) {
    //     $scope.last_16.runners_up[group_name] = {team_id: runner_up.id, team_name: runner_up.name};
    //   } else {
    //     $scope.last_16.runners_up[group_name] = {team_id: undefined, team_name: undefined};
    //   }
    // });

    // predictionServices.saveGroupStage(group_standings);
  }

  $scope.populateKnockoutStage = function(){
    if(angular.isUndefined($scope.quarter_f)){
      $scope.quarter_f = {};
    }
    if(angular.isUndefined($scope.semi_f)){
      $scope.semi_f = {};
    }
    if(angular.isUndefined($scope.finalists)){
      $scope.finalists = {};
    }
    if(angular.isUndefined($scope.champion)){
      $scope.champion = {};
    }

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
