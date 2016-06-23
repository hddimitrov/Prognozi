angular.module('pro').controller('results', ['$scope', '$filter', 'predictionServices', function($scope, $filter, predictionServices) {
  $scope.groups = {};
  $scope.third_placed_teams = {};
  $scope.third_standings = ''
  $scope.last_16_top = {};
  $scope.last_16_bottom = {};
  // $scope.eliminations = {};
  $scope.quarter_f = {};
  $scope.semi_f = {};
  $scope.finalists = {};
  $scope.champion = {};

  $scope.loadResults = function(user_id) {
    predictionServices.loadGroupStage(user_id).then(function(response) {
      $scope.groups = response;
      angular.forEach($scope.groups, function(value, group_name) {
        $scope.calculateGroupStandings(group_name);
      })
    });
  }

  $scope.calculateGroupStandings = function(group_name) {
    angular.forEach($scope.groups[group_name].teams, function(team, key) {
      team.points = 0;
      team.matches_played = 0;
      team.matches_won = 0;
      team.matches_drawn = 0;
      team.matches_lost = 0;
      team.goals_for = 0;
      team.goals_against = 0;
      team.goal_difference = 0;
      team.tb = 1;
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

    $scope.resolveTiebreaks(group_name);
  };
  $scope.resolveTiebreaks = function(group_name) {
    tb_needed = {};
    ordered = $filter('orderBy')($scope.groups[group_name].teams, ['-points']);
    for (var i = 0, len = ordered.length; i < len - 1; i++) {
      if(ordered[i].points == ordered[i+1].points) {
        points = ordered[i].points;
        if(tb_needed[points] == undefined) {
          tb_needed[points] = [];
        }
        if (tb_needed[points].slice(-1)[0] != ordered[i]) {
          tb_needed[points].push(ordered[i]);
        }
        if (tb_needed[points].slice(-1)[0] != ordered[i+1]) {
          tb_needed[points].push(ordered[i + 1]);
        }
      }
    }
    angular.forEach(tb_needed, function(teams, key) {
      if(teams.length == 2) {
        angular.forEach($scope.groups[group_name].matches, function(match, key) {
          if(match.host_team == teams[0].name && match.guest_team == teams[1].name) {
            if(match.host_prediction > match.guest_prediction) {
              teams[0].tb = 1
              teams[1].tb = 2
            }
            if(match.host_prediction < match.guest_prediction) {
              teams[0].tb = 2
              teams[1].tb = 1
            }
          }
          if (match.host_team == teams[1].name && match.guest_team == teams[0].name) {
            if(match.host_prediction > match.guest_prediction) {
              teams[1].tb = 1
              teams[0].tb = 2
            }
            if(match.host_prediction < match.guest_prediction) {
              teams[1].tb = 2
              teams[0].tb = 1
            }
          }
        });
      }
      if(teams.length == 3) {
        for (var i = 0; i < 3; i++) {
          teams[i].tb_points = 0;
          teams[i].tb_goals_for = 0;
          teams[i].tb_goal_difference = 0;
        }
        angular.forEach($scope.groups[group_name].matches, function(match, key) {
          if(match.host_prediction !== null && match.guest_prediction !== null){
            host = $filter('getByProperty')('name', match.host_team, teams);
            guest = $filter('getByProperty')('name', match.guest_team, teams);
            if(host !== null && guest !== null) {
              if(host.name == match.host_team){
                host.tb_goal_difference += match.host_prediction;
                host.tb_goal_difference -= match.guest_prediction;
                host.tb_goals_for += match.host_prediction;
              }
              if(guest.name == match.guest_team){
                guest.tb_goal_difference += match.guest_prediction;
                guest.tb_goal_difference -= match.host_prediction;
                guest.tb_goals_for += match.guest_prediction;
              }
              if(match.host_prediction == match.guest_prediction){
                host.tb_points += 1;
                guest.tb_points += 1;
              }
              if(match.host_prediction > match.guest_prediction){
                host.tb_points += 3;
              }
              if(match.host_prediction < match.guest_prediction){
                guest.tb_points += 3;
              }
            }
          }
        });
        breaked = $filter('orderBy')(teams, ['-tb_points', '-tb_goal_difference', '-tb_goals_for']);
        for (var i = 0; i < 3; i++) {
          breaked[i].tb = i+1;
        }
      }
    });
    $scope.calculateQualifiedTeams();
  };

  $scope.calculateQualifiedTeams = function() {
    group_standings = {};
    angular.forEach($scope.groups, function(value, group_name) {
      group_standings[group_name] = $filter('orderBy')($scope.groups[group_name].teams, ['-points','tb','-goal_difference', '-goals_for', '-coef']);
      for(i=1;i<=group_standings[group_name].length; i++) {
        if (i == 3) {
          group_standings[group_name][i-1].group = group_name;
          $scope.third_placed_teams[group_name] = group_standings[group_name][i-1];
        }
      }
    });
    teams = [];
    angular.forEach($scope.third_placed_teams, function(value, key) {
      teams.push(value);
    });
    $scope.third_standings = $filter('orderBy')(teams, ['-points','-goal_difference','-goals_for','-coef']);
    $scope.third_standings = $.map($scope.third_standings, function(n) {return n.group;}).slice(0,4).sort().join('');
  };
}]);
