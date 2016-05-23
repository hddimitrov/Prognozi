angular.module('pro').controller('points_testing', ['$scope', '$filter', function($scope, $filter) {
  $scope.points = {sign: 1, score: 5, gs_1: 4, gs_2: 3, gs_3: 2, gs_4: 1, ef: 3, qf: 6, sf: 12, f: 18, c: 24, ts: 7}
  $scope.users = [];
  // $scope.users[0] = {name: 'Janko', signs: 10, scores: 4, gs_1s: 6, gs_2s: 4, gs_3s: 3, gs_4s: 3, efs: 10, qfs: 4, sfs: 0, fs: 0, cs: 0, tss: 0, points: 0}
  // $scope.users[1] = {name: 'Panko', signs: 15, scores: 2, gs_1s: 6, gs_2s: 4, gs_3s: 1, gs_4s: 3, efs: 12, qfs: 5, sfs: 2, fs: 1, cs: 0, tss: 0, points: 0};
  // $scope.users[2] = {name: 'Vanko', signs: 8, scores: 12, gs_1s: 5, gs_2s: 4, gs_3s: 6, gs_4s: 3, efs: 14, qfs: 6, sfs: 2, fs: 0, cs: 0, tss: 1, points: 0}
  // $scope.users[3] = {name: 'Ganko', signs: 10, scores: 3, gs_1s: 5, gs_2s: 5, gs_3s: 2, gs_4s: 3, efs: 10, qfs: 7, sfs: 1, fs: 1, cs: 1, tss: 0, points: 0}
  // $scope.users[4] = {name: 'Danko', signs: 8, scores: 3, gs_1s: 4, gs_2s: 6, gs_3s: 4, gs_4s: 3, efs: 13, qfs: 6, sfs: 2, fs: 1, cs: 1, tss: 0, points: 0}
  // $scope.users[5] = {name: 'Manko', signs: 15, scores: 3, gs_1s: 4, gs_2s: 2, gs_3s: 3, gs_4s: 3, efs: 14, qfs: 7, sfs: 1, fs: 0, cs: 0, tss: 0, points: 0}
  // $scope.users[6] = {name: 'Zanko', signs: 20, scores: 4, gs_1s: 3, gs_2s: 5, gs_3s: 3, gs_4s: 3, efs: 11, qfs: 5, sfs: 2, fs: 2, cs: 1, tss: 0, points: 0}
  // $scope.users[7] = {name: 'Ranko', signs: 20, scores: 6, gs_1s: 3, gs_2s: 5, gs_3s: 5, gs_4s: 3, efs: 9, qfs: 4, sfs: 3, fs: 1, cs: 1, tss: 0, points: 0}
  // $scope.users[8] = {name: 'Kanko', signs: 15, scores: 6, gs_1s: 2, gs_2s: 6, gs_3s: 4, gs_4s: 3, efs: 15, qfs: 7, sfs: 3, fs: 2, cs: 0, tss: 0, points: 0}
  // $scope.users[9] = {name: 'Lanko', signs: 10, scores: 6, gs_1s: 2, gs_2s: 6, gs_3s: 5, gs_4s: 3, efs: 14, qfs: 6, sfs: 2, fs: 2, cs: 1, tss: 0, points: 0}
  $scope.users[0] = {name: 'Ari'      ,signs:24, scores: 4,gs_1s: 2, gs_2s: 2, gs_3s: 2, gs_4s: 2, efs: 10, qfs: 5, sfs: 2, fs: 1, cs: 1, tss: 1, points: 0}
  $scope.users[1] = {name: 'Barry'    ,signs:18, scores: 3,gs_1s: 4, gs_2s: 4, gs_3s: 4, gs_4s: 4, efs: 14, qfs: 7, sfs: 3, fs: 2, cs: 1, tss: 0, points: 0}
  $scope.users[2] = {name: 'Charlie'  ,signs:18, scores: 4,gs_1s: 4, gs_2s: 4, gs_3s: 2, gs_4s: 2, efs: 14, qfs: 6, sfs: 2, fs: 1, cs: 1, tss: 0, points: 0}
  $scope.users[3] = {name: 'Danny'    ,signs:24, scores: 5,gs_1s: 4, gs_2s: 5, gs_3s: 3, gs_4s: 3, efs: 12, qfs: 7, sfs: 3, fs: 2, cs: 0, tss: 1, points: 0}
  $scope.users[4] = {name: 'Ferry 50%',signs:18, scores: 9,gs_1s: 3, gs_2s: 3, gs_3s: 3, gs_4s: 3, efs: 8 , qfs: 4, sfs: 2, fs: 1, cs: 1, tss: 1, points: 0}
  $scope.users[5] = {name: 'Farry 33%',signs:12, scores: 6,gs_1s: 2, gs_2s: 2, gs_3s: 2, gs_4s: 2, efs: 6 , qfs: 3, sfs: 2, fs: 1, cs: 0, tss: 0, points: 0}
  $scope.users[6] = {name: 'Harry Avg',signs:15, scores: 4,gs_1s: 4, gs_2s: 2, gs_3s: 2, gs_4s: 4, efs: 11, qfs: 4, sfs: 2, fs: 1, cs: 0, tss: 1, points: 0}
  $scope.users[7] = {name: 'Jerry'    ,signs:21, scores: 7,gs_1s: 5, gs_2s: 4, gs_3s: 4, gs_4s: 4, efs: 11, qfs: 4, sfs: 2, fs: 1, cs: 0, tss: 0, points: 0}
  $scope.users[9] = {name: 'Karie'    ,signs:14, scores: 2,gs_1s: 4, gs_2s: 4, gs_3s: 3, gs_4s: 3, efs: 12, qfs: 6, sfs: 3, fs: 1, cs: 1, tss: 0, points: 0}
  $scope.ctrl_user = {};

  $scope.calculatePoints = function(){
    $scope.ctrl_user.points = 0;
    $scope.ctrl_user.points += ($scope.ctrl_user.signs || 0) * ($scope.points.sign || 0)
    $scope.ctrl_user.points += ($scope.ctrl_user.scores || 0) * ($scope.points.score || 0)
    $scope.ctrl_user.points += ($scope.ctrl_user.gs_1s || 0) * ($scope.points.gs_1 || 0)
    $scope.ctrl_user.points += ($scope.ctrl_user.gs_2s || 0) * ($scope.points.gs_2 || 0)
    $scope.ctrl_user.points += ($scope.ctrl_user.gs_3s || 0) * ($scope.points.gs_3 || 0)
    $scope.ctrl_user.points += ($scope.ctrl_user.gs_4s || 0) * ($scope.points.gs_4 || 0)
    $scope.ctrl_user.points += ($scope.ctrl_user.efs || 0) * ($scope.points.ef || 0)
    $scope.ctrl_user.points += ($scope.ctrl_user.qfs || 0) * ($scope.points.qf || 0)
    $scope.ctrl_user.points += ($scope.ctrl_user.sfs || 0) * ($scope.points.sf || 0)
    $scope.ctrl_user.points += ($scope.ctrl_user.fs || 0) * ($scope.points.f || 0)
    $scope.ctrl_user.points += ($scope.ctrl_user.cs || 0) * ($scope.points.c || 0)
    $scope.ctrl_user.points += ($scope.ctrl_user.tss || 0) * ($scope.points.ts || 0)

    angular.forEach($scope.users, function(user, key) {
      user.points = 0;
      user.points += user.signs * ($scope.points.sign || 0)
      user.points += user.scores * ($scope.points.score || 0)
      user.points += user.gs_1s * ($scope.points.gs_1 || 0)
      user.points += user.gs_2s * ($scope.points.gs_2 || 0)
      user.points += user.gs_3s * ($scope.points.gs_3 || 0)
      user.points += user.gs_4s * ($scope.points.gs_4 || 0)
      user.points += user.efs * ($scope.points.ef || 0)
      user.points += user.qfs * ($scope.points.qf || 0)
      user.points += user.sfs * ($scope.points.sf || 0)
      user.points += user.fs * ($scope.points.f || 0)
      user.points += user.cs * ($scope.points.c || 0)
      user.points += user.tss * ($scope.points.ts || 0)
    });
  }

  $scope.add_ctrl_user = function(){
    cu = $scope.ctrl_user;
    new_user = {};
    new_user = {name: cu.name, signs: cu.signs, scores: cu.scores, gs_1s: cu.gs_1s, gs_2s: cu.gs_2s, gs_3s: cu.gs_3s, gs_4s: cu.gs_4s, efs: cu.efs, qfs: cu.qfs, sfs: cu.sfs, fs: cu.fs, cs: cu.cs, tss: cu.tss, points: cu.points}
    $scope.users[$scope.users.length] = new_user;
  }

  $scope.calculatePoints();
}]);
