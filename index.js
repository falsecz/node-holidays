
exports.locale = function (name) {
  var cal = require("./data/" + name + ".json");
  var find = function(date) {
    for (var i=0; i < cal.length; i++){
      if(date >= new Date(cal[i].start) && date < new Date(cal[i].end)) {
        return cal[i];
      }
    }
    return false;
  };

  var findAfter = function (date) {
    var h = find(date)
    if (h) {
      var d = new Date(h.end);
      // d.setSeconds(d.getSeconds() + 1);
      return findAfter(d);
    }
    return date;
  }

  var isWeekend = function (d) {
    return [0, 6].indexOf(d.getDay()) > -1;
  };

  var isHoliday = function (d) {
    return !!find(d);
  };

  var applyHolidays = function (d, shiftByDays, skipWeekdays) {
    // console.log("Zacinam na ", d, shiftByDays, skipWeekdays)
    d = new Date(d);
    // var minutes = d.getMinutes();
    // var hours = d.getHours();


    if(isHoliday(d) || (skipWeekdays && isWeekend(d))) {
      // if(isHoliday(d)) {
      //   console.log("je to svatek" );
      // }
      // else {
      //   console.log("je to vikend" );
      //
      // }
      // minutes = 0;
      // hours = 24;
      d.setMinutes(0);
      d.setHours(24);

    }



    for (var i = 0; i <= shiftByDays; i++) {

        if (isHoliday(d)) {
          // console.log("Pridavam den po svatku", d);
          shiftByDays++;
          // cur.setHours(0);
          // cur.setMinutes(0);
        }
        else if (skipWeekdays && isWeekend(d)) {
            // console.log("Den " + cur.getDay(), cur);
          // console.log("Pridavam den po vikendu", d);
          shiftByDays++;

          // cur.setHours(0);
          // cur.setMinutes(0);
        }
        d.setDate(d.getDate() + 1);


    }
    d.setDate(d.getDate() - 1);

    // console.log("vracim", hours, minutes)
    // d.setMinutes(minutes);
    // d.setHours(hours);

    return d;
  }

  var ensureBusinessDays = function (d, shiftByDays) {
    return applyHolidays(d, shiftByDays, true);
  }


  return {
    dates: cal,
    find: find,
    findAfter: findAfter,
    ensureBusinessDays: ensureBusinessDays
  }
}
