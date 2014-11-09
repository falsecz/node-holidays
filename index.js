exports.locale = function (name) {
  var cal = require("./data/" + name + ".json");
  var find = function(date) {
    for (var i=0; i < cal.length; i++){
      if(date > new Date(cal[i].start) && date < new Date(cal[i].end)) {
        return cal[i];
      }
    }
    return false;
  };

  var findAfter = function (date) {
    var h = find(date)
    if (h) {
      var d = new Date(h.end);
      d.setSeconds(d.getSeconds() + 1);
      return findAfter(d);
    }
    return date;
  }

  var shiftByDays = function (date, days) {
    var cur = new Date(date);

    for (var i = 0; i < days; i++) {
        cur.setDate(cur.getDate() + 1);
        if (cur != findAfter(cur)) days++;
    }

    return cur;
  }

  return {
    dates: cal,
    find: find,
    findAfter: findAfter,
    shiftByDays: shiftByDays
  }
}
