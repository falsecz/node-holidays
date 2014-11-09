process.env.TZ = "Europe/Prague"

holidays = require '../'

cal = holidays.locale 'cz'

[
	"2015-09-28T01:00:00.000"
	"2015-09-28T00:00:00.000"
	"2015-09-28T21:59:00.000"

	"2015-09-27T21:59:00.000"
	"2015-09-29T02:00:00.000"
].forEach (d) ->
	d = new Date d
	console.log  d, JSON.stringify cal.find d

console.log cal.findAfter new Date "2014-12-24T21:59:00.000"
console.log cal.findAfter new Date "2015-09-28T21:59:00.000"

