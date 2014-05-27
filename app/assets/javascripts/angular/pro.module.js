angular.module('pro', ['pro.directives', 'prediction_services'])

angular.module('pro').config(['$locationProvider', function(lProvider) {
  lProvider.html5Mode(false);
}]);

angular.module('pro').config(['$httpProvider', function(provider) {
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}]);
