angular.module('pro').controller('predictions', ['$scope', '$filter', 'predictionServices', function($scope, $filter, predictionServices) {
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

  $scope.current_group = 'A';

  predictionServices.loadGroupStage().then(function(response) {
    $scope.groups = response;
    angular.forEach($scope.groups, function(value, group_name) {
      $scope.calculateGroupStandings(group_name);
    })
  });

  $scope.predictMatch = function(match){
    prediction = {};
    prediction[match.id] = {host: match.host_prediction, guest: match.guest_prediction};
    predictionServices.predictMatch(prediction).then(function(response){
      $scope.calculateGroupStandings($scope.current_group)
    });
  };

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
              console.log(match.start_at);
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
      console.log(group_standings[group_name]);
      for(i=1;i<=group_standings[group_name].length; i++) {
        if(i == 1) {
          if(group_name == 'A') {
            $scope.last_16_top[7] = {team_id: group_standings[group_name][i-1].id, team_name: group_standings[group_name][i-1].name};
          }
          if(group_name == 'B') {
            $scope.last_16_top[3] = {team_id: group_standings[group_name][i-1].id, team_name: group_standings[group_name][i-1].name};
          }
          if(group_name == 'C') {
            $scope.last_16_top[5] = {team_id: group_standings[group_name][i-1].id, team_name: group_standings[group_name][i-1].name};
          }
          if(group_name == 'D') {
            $scope.last_16_top[2] = {team_id: group_standings[group_name][i-1].id, team_name: group_standings[group_name][i-1].name};
          }
          if(group_name == 'E') {
            $scope.last_16_top[6] = {team_id: group_standings[group_name][i-1].id, team_name: group_standings[group_name][i-1].name};
          }
          if(group_name == 'F') {
            $scope.last_16_top[4] = {team_id: group_standings[group_name][i-1].id, team_name: group_standings[group_name][i-1].name};
          }
        }
        if(i == 2) {
          if(group_name == 'A') {
            $scope.last_16_top[1] = {team_id: group_standings[group_name][i-1].id, team_name: group_standings[group_name][i-1].name};
          }
          if(group_name == 'B') {
            $scope.last_16_top[8] = {team_id: group_standings[group_name][i-1].id, team_name: group_standings[group_name][i-1].name};
          }
          if(group_name == 'C') {
            $scope.last_16_bottom[1] = {team_id: group_standings[group_name][i-1].id, team_name: group_standings[group_name][i-1].name};
          }
          if(group_name == 'D') {
            $scope.last_16_bottom[6] = {team_id: group_standings[group_name][i-1].id, team_name: group_standings[group_name][i-1].name};
          }
          if(group_name == 'E') {
            $scope.last_16_bottom[4] = {team_id: group_standings[group_name][i-1].id, team_name: group_standings[group_name][i-1].name};
          }
          if(group_name == 'F') {
            $scope.last_16_bottom[8] = {team_id: group_standings[group_name][i-1].id, team_name: group_standings[group_name][i-1].name};
          }
        }
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
    console.log(teams)
    $scope.third_standings = $filter('orderBy')(teams, ['-points','-goal_difference','-goals_for','-coef']);
    $scope.third_standings = $.map($scope.third_standings, function(n) {return n.group;}).slice(0,4).sort().join('');
    console.log($scope.third_standings);
    if($scope.third_standings == 'ABCD') {
      $scope.last_16_bottom[7] = {team_id: $scope.third_placed_teams['C'].id, team_name: $scope.third_placed_teams['C'].name};
      $scope.last_16_bottom[3] = {team_id: $scope.third_placed_teams['D'].id, team_name: $scope.third_placed_teams['D'].name};
      $scope.last_16_bottom[5] = {team_id: $scope.third_placed_teams['A'].id, team_name: $scope.third_placed_teams['A'].name};
      $scope.last_16_bottom[2] = {team_id: $scope.third_placed_teams['B'].id, team_name: $scope.third_placed_teams['B'].name};
    }
    if($scope.third_standings == 'ABCE') {
      $scope.last_16_bottom[7] = {team_id: $scope.third_placed_teams['C'].id, team_name: $scope.third_placed_teams['C'].name};
      $scope.last_16_bottom[3] = {team_id: $scope.third_placed_teams['A'].id, team_name: $scope.third_placed_teams['A'].name};
      $scope.last_16_bottom[5] = {team_id: $scope.third_placed_teams['B'].id, team_name: $scope.third_placed_teams['B'].name};
      $scope.last_16_bottom[2] = {team_id: $scope.third_placed_teams['E'].id, team_name: $scope.third_placed_teams['E'].name};
    }
    if($scope.third_standings == 'ABCF') {
      $scope.last_16_bottom[7] = {team_id: $scope.third_placed_teams['C'].id, team_name: $scope.third_placed_teams['C'].name};
      $scope.last_16_bottom[3] = {team_id: $scope.third_placed_teams['A'].id, team_name: $scope.third_placed_teams['A'].name};
      $scope.last_16_bottom[5] = {team_id: $scope.third_placed_teams['B'].id, team_name: $scope.third_placed_teams['B'].name};
      $scope.last_16_bottom[2] = {team_id: $scope.third_placed_teams['F'].id, team_name: $scope.third_placed_teams['F'].name};
    }
    if($scope.third_standings == 'ABDE') {
      $scope.last_16_bottom[7] = {team_id: $scope.third_placed_teams['D'].id, team_name: $scope.third_placed_teams['D'].name};
      $scope.last_16_bottom[3] = {team_id: $scope.third_placed_teams['A'].id, team_name: $scope.third_placed_teams['A'].name};
      $scope.last_16_bottom[5] = {team_id: $scope.third_placed_teams['B'].id, team_name: $scope.third_placed_teams['B'].name};
      $scope.last_16_bottom[2] = {team_id: $scope.third_placed_teams['E'].id, team_name: $scope.third_placed_teams['E'].name};
    }
    if($scope.third_standings == 'ABDF') {
      $scope.last_16_bottom[7] = {team_id: $scope.third_placed_teams['D'].id, team_name: $scope.third_placed_teams['D'].name};
      $scope.last_16_bottom[3] = {team_id: $scope.third_placed_teams['A'].id, team_name: $scope.third_placed_teams['A'].name};
      $scope.last_16_bottom[5] = {team_id: $scope.third_placed_teams['B'].id, team_name: $scope.third_placed_teams['B'].name};
      $scope.last_16_bottom[2] = {team_id: $scope.third_placed_teams['F'].id, team_name: $scope.third_placed_teams['F'].name};
    }
    if($scope.third_standings == 'ABEF') {
      $scope.last_16_bottom[7] = {team_id: $scope.third_placed_teams['E'].id, team_name: $scope.third_placed_teams['E'].name};
      $scope.last_16_bottom[3] = {team_id: $scope.third_placed_teams['A'].id, team_name: $scope.third_placed_teams['A'].name};
      $scope.last_16_bottom[5] = {team_id: $scope.third_placed_teams['B'].id, team_name: $scope.third_placed_teams['B'].name};
      $scope.last_16_bottom[2] = {team_id: $scope.third_placed_teams['F'].id, team_name: $scope.third_placed_teams['F'].name};
    }
    if($scope.third_standings == 'ACDE') {
      $scope.last_16_bottom[7] = {team_id: $scope.third_placed_teams['C'].id, team_name: $scope.third_placed_teams['C'].name};
      $scope.last_16_bottom[3] = {team_id: $scope.third_placed_teams['D'].id, team_name: $scope.third_placed_teams['D'].name};
      $scope.last_16_bottom[5] = {team_id: $scope.third_placed_teams['A'].id, team_name: $scope.third_placed_teams['A'].name};
      $scope.last_16_bottom[2] = {team_id: $scope.third_placed_teams['E'].id, team_name: $scope.third_placed_teams['E'].name};
    }
    if($scope.third_standings == 'ACDF') {
      $scope.last_16_bottom[7] = {team_id: $scope.third_placed_teams['C'].id, team_name: $scope.third_placed_teams['C'].name};
      $scope.last_16_bottom[3] = {team_id: $scope.third_placed_teams['D'].id, team_name: $scope.third_placed_teams['D'].name};
      $scope.last_16_bottom[5] = {team_id: $scope.third_placed_teams['A'].id, team_name: $scope.third_placed_teams['A'].name};
      $scope.last_16_bottom[2] = {team_id: $scope.third_placed_teams['F'].id, team_name: $scope.third_placed_teams['F'].name};
    }
    if($scope.third_standings == 'ACEF') {
      $scope.last_16_bottom[7] = {team_id: $scope.third_placed_teams['C'].id, team_name: $scope.third_placed_teams['C'].name};
      $scope.last_16_bottom[3] = {team_id: $scope.third_placed_teams['A'].id, team_name: $scope.third_placed_teams['A'].name};
      $scope.last_16_bottom[5] = {team_id: $scope.third_placed_teams['F'].id, team_name: $scope.third_placed_teams['F'].name};
      $scope.last_16_bottom[2] = {team_id: $scope.third_placed_teams['E'].id, team_name: $scope.third_placed_teams['E'].name};
    }
    if($scope.third_standings == 'ADEF') {
      $scope.last_16_bottom[7] = {team_id: $scope.third_placed_teams['D'].id, team_name: $scope.third_placed_teams['D'].name};
      $scope.last_16_bottom[3] = {team_id: $scope.third_placed_teams['A'].id, team_name: $scope.third_placed_teams['A'].name};
      $scope.last_16_bottom[5] = {team_id: $scope.third_placed_teams['F'].id, team_name: $scope.third_placed_teams['F'].name};
      $scope.last_16_bottom[2] = {team_id: $scope.third_placed_teams['E'].id, team_name: $scope.third_placed_teams['E'].name};
    }
    if($scope.third_standings == 'BCDE') {
      $scope.last_16_bottom[7] = {team_id: $scope.third_placed_teams['C'].id, team_name: $scope.third_placed_teams['C'].name};
      $scope.last_16_bottom[3] = {team_id: $scope.third_placed_teams['D'].id, team_name: $scope.third_placed_teams['D'].name};
      $scope.last_16_bottom[5] = {team_id: $scope.third_placed_teams['B'].id, team_name: $scope.third_placed_teams['B'].name};
      $scope.last_16_bottom[2] = {team_id: $scope.third_placed_teams['E'].id, team_name: $scope.third_placed_teams['E'].name};
    }
    if($scope.third_standings == 'BCDF') {
      $scope.last_16_bottom[7] = {team_id: $scope.third_placed_teams['C'].id, team_name: $scope.third_placed_teams['C'].name};
      $scope.last_16_bottom[3] = {team_id: $scope.third_placed_teams['D'].id, team_name: $scope.third_placed_teams['D'].name};
      $scope.last_16_bottom[5] = {team_id: $scope.third_placed_teams['B'].id, team_name: $scope.third_placed_teams['B'].name};
      $scope.last_16_bottom[2] = {team_id: $scope.third_placed_teams['F'].id, team_name: $scope.third_placed_teams['F'].name};
    }
    if($scope.third_standings == 'BCEF') {
      $scope.last_16_bottom[7] = {team_id: $scope.third_placed_teams['E'].id, team_name: $scope.third_placed_teams['E'].name};
      $scope.last_16_bottom[3] = {team_id: $scope.third_placed_teams['C'].id, team_name: $scope.third_placed_teams['C'].name};
      $scope.last_16_bottom[5] = {team_id: $scope.third_placed_teams['B'].id, team_name: $scope.third_placed_teams['B'].name};
      $scope.last_16_bottom[2] = {team_id: $scope.third_placed_teams['F'].id, team_name: $scope.third_placed_teams['F'].name};
    }
    if($scope.third_standings == 'BDEF') {
      $scope.last_16_bottom[7] = {team_id: $scope.third_placed_teams['E'].id, team_name: $scope.third_placed_teams['E'].name};
      $scope.last_16_bottom[3] = {team_id: $scope.third_placed_teams['D'].id, team_name: $scope.third_placed_teams['D'].name};
      $scope.last_16_bottom[5] = {team_id: $scope.third_placed_teams['B'].id, team_name: $scope.third_placed_teams['B'].name};
      $scope.last_16_bottom[2] = {team_id: $scope.third_placed_teams['F'].id, team_name: $scope.third_placed_teams['F'].name};
    }
    if($scope.third_standings == 'CDEF') {
      $scope.last_16_bottom[7] = {team_id: $scope.third_placed_teams['C'].id, team_name: $scope.third_placed_teams['C'].name};
      $scope.last_16_bottom[3] = {team_id: $scope.third_placed_teams['D'].id, team_name: $scope.third_placed_teams['D'].name};
      $scope.last_16_bottom[5] = {team_id: $scope.third_placed_teams['F'].id, team_name: $scope.third_placed_teams['F'].name};
      $scope.last_16_bottom[2] = {team_id: $scope.third_placed_teams['E'].id, team_name: $scope.third_placed_teams['E'].name};
    }
    if(angular.isUndefined($scope.eliminations)) {
      predictionServices.loadKnockoutStage().then(function(response){
        $scope.eliminations = response;
        $scope.populateKnockoutStage();
      });
    } else {
      $scope.populateKnockoutStage();
    }
  };

  $scope.populateKnockoutStage = function() {
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

    angular.forEach($scope.last_16_top, function(value, key) {
      if(angular.isDefined(value.team_id) && $filter('getByProperty')('team_id', value.team_id, $scope.eliminations.qf) !== null){
        if(key == 1){
          $scope.quarter_f[37] = value;
        }
        if(key == 2){
          $scope.quarter_f[39] = value;
        }
        if(key == 3){
          $scope.quarter_f[38] = value;
        }
        if(key == 4){
          $scope.quarter_f[42] = value;
        }
        if(key == 5){
          $scope.quarter_f[41] = value;
        }
        if(key == 6){
          $scope.quarter_f[43] = value;
        }
        if(key == 7){
          $scope.quarter_f[40] = value;
        }
        if(key == 8){
          $scope.quarter_f[44] = value;
        }
      }
    });

    angular.forEach($scope.last_16_bottom, function(value, key) {
      if(angular.isDefined(value.team_id) && $filter('getByProperty')('team_id', value.team_id, $scope.eliminations.qf) !== null){
        if(key == 1){
          $scope.quarter_f[37] = value;
        }
        if(key == 2){
          $scope.quarter_f[39] = value;
        }
        if(key == 3){
          $scope.quarter_f[38] = value;
        }
        if(key == 4){
          $scope.quarter_f[42] = value;
        }
        if(key == 5){
          $scope.quarter_f[41] = value;
        }
        if(key == 6){
          $scope.quarter_f[43] = value;
        }
        if(key == 7){
          $scope.quarter_f[40] = value;
        }
        if(key == 8){
          $scope.quarter_f[44] = value;
        }
      }
    });

    angular.forEach($scope.quarter_f, function(value, key) {
      if(angular.isDefined(value.team_id) && $filter('getByProperty')('team_id', value.team_id, $scope.eliminations.sf) !== null){
        if(key == 37 || key == 39){
          $scope.semi_f[45] = value;
        }
        if(key == 38 || key == 42){
          $scope.semi_f[46] = value;
        }
        if(key == 41 || key == 43){
          $scope.semi_f[47] = value;
        }
        if(key == 40 || key == 44){
          $scope.semi_f[48] = value;
        }
      }
    });

    angular.forEach($scope.semi_f, function(value, key) {
      if(angular.isDefined(value.team_id) && $filter('getByProperty')('team_id', value.team_id, $scope.eliminations.f) !== null){
        if(key == 45 || key == 46){
          $scope.finalists[49] = value;
        }
        if(key == 47 || key == 48){
          $scope.finalists[50] = value;
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
    $scope.save_knockout_stage();
  };

  $scope.go_through_sf = function(qf, team_id, team_name) {
    $scope.semi_f[qf] = {team_id: team_id, team_name: team_name};
    $scope.save_knockout_stage();
  };

  $scope.go_through_f = function(sf, team_id, team_name) {
    $scope.finalists[sf] = {team_id: team_id, team_name: team_name};
    $scope.save_knockout_stage();
  };

  $scope.win = function(team_id, team_name) {
    $scope.champion = {team_id: team_id, team_name: team_name};
    $scope.save_knockout_stage();
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
