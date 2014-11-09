assert = require 'assert'
holidays = require '../'

process.env.TZ = "Europe/Prague"

cal = holidays.locale 'cz'

[
	"2015-09-28T01:00:00.000Z"
	"2015-09-28T00:00:00.000Z"
	"2015-09-28T21:59:00.000Z"
].forEach (d) ->
	d = new Date d
	assert.equal cal.find(d).name, 'Den české státnosti'

[
	"2015-09-27T21:59:00.000Z"
	"2015-09-29T02:00:00.000Z"
].forEach (d) ->
	assert.equal cal.find(d), false, 'nejsou svatky'

[
	["2015-12-15T00:00:00.000Z", "2015-12-15T00:00:00.000Z"]
	["2015-09-28T21:59:00.000Z", "2015-09-29T21:59:00.000Z"]
	["2014-12-24T21:59:00.000Z", "2014-12-27T21:59:00.000Z"]
].forEach (range) ->
	result = cal.findAfter(new Date range[0]).toISOString()
	expected = range[1]
	assert.equal result, expected, "findAfter #{result} != #{expected}"

[
	['2014-12-24T01:00:00.000Z', '2014-12-28T01:00:00.000Z']
	['2014-12-23T01:00:00.000Z', '2014-12-28T01:00:00.000Z']
	['2014-12-22T01:00:00.000Z', '2014-12-27T01:00:00.000Z']
	['2014-12-21T01:00:00.000Z', '2014-12-23T01:00:00.000Z']

].forEach (range) ->
	a = new Date range[0]
	expected = new Date range[1]

	result = cal.shiftByDays a, 2

	assert.equal result.getTime(), expected.getTime(), "shiftByDays #{result} != #{expected}"


