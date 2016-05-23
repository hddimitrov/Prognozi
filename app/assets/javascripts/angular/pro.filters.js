angular.module('pro.filters', []);

angular.module('pro.filters').filter('getByProperty', function() {
  return function(propertyName, propertyValue, collection) {
    var i=0, len = collection.length;
    for (; i < len; i++) {
      if (collection[i][propertyName] == propertyValue) {
        return collection[i];
      }
    }
    return null;
  }
});

angular.module('pro.filters').filter('toArray', function () {
  'use strict';

  return function (obj) {
  if (!(obj instanceof Object)) {
    return obj;
  }
  return Object.keys(obj).map(function (key) {
    return Object.defineProperty(obj[key], '$key', {__proto__: null, value: key});
    });
  }
});

