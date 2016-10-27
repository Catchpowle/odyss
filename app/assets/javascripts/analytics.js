//= require ./mixpanel
/* globals Cookies, mixpanel */

(function() {
  "use strict";

  var analytics = Cookies.get("analytics");

  if(analytics) {
    var parsed_analytics = JSON.parse(analytics);
    $.each(parsed_analytics, function(index, value) {
      if(value["alias"]) {
        mixpanel.alias(value["alias"]);
        mixpanel.people.set(value["people_set"]);
      }
      if(value["identify"]) {
        mixpanel.identify(value["identify"]);
      }
      if(value["track"]) {
        $.each(value["track"], function(index, value) {
          mixpanel.track(value[0], value[1]);
        });
      }
      if(index === (parsed_analytics.length - 1)) {
        mixpanel.track('page_viewed');
      }
      if(value["reset"]) {
        mixpanel.reset();
      }
    });

    Cookies.remove('analytics');
  }
})();
