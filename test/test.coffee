assert = require 'assert'
holidays = require '../'
moment = require 'moment-timezone'

FORMAT = "YYYY-MM-DD HH:mm:ss"
process.env.TZ = TZ = "Europe/Prague"

cal = holidays.locale 'cz'

describe "ranging Den české státnosti", ->

	[
		"2015-09-28 01:00:00"
		"2015-09-28 00:00:00"
		"2015-09-28 21:59:00"
	].forEach (d) ->
		it d, -> assert.equal cal.find(moment(d).toDate()).name, 'Den české státnosti'

describe "ranging outside holiday", ->
	[
		"2015-09-27 23:59:59"
		"2015-09-29 01:00:00"
		"2015-09-29 00:00:00"
	].forEach (d) ->
		it d, -> assert.equal cal.find(moment(d).toDate()), no, 'nejsou svatky'

describe "find after", ->
	[
		["2015-12-15 00:00:00", "2015-12-15 00:00:00"]
		["2015-09-28 23:59:59", "2015-09-29 00:00:00"]
		["2014-12-24 23:59:00", "2014-12-27 00:00:00"]
	].forEach (testSet) ->
		[arg, expected] = testSet
		it "Move #{arg} to #{expected}", ->
			result = cal.findAfter(moment(arg).toDate())
			result = moment(result).format(FORMAT)
			assert.equal result, expected, "findAfter #{expected} not #{result}"

describe "apply holidays for 2-day long offer-time", ->
	[
		['2014-11-22 15:00:00', '2014-11-26 00:00:00']
		['2014-10-28 18:00:00', '2014-10-31 00:00:00']
		['2014-12-24 01:00:00', '2014-12-31 00:00:00']
		['2014-12-24 15:00:00', '2014-12-31 00:00:00']
		['2014-12-23 01:00:00', '2014-12-30 01:00:00']
		['2014-12-23 15:00:00', '2014-12-30 15:00:00']
		['2014-12-22 01:00:00', '2014-12-29 01:00:00']
		['2014-12-22 15:00:00', '2014-12-29 15:00:00']
		['2014-12-21 01:00:00', '2014-12-29 00:00:00']
		['2014-12-21 15:00:00', '2014-12-29 00:00:00']

	].forEach (testSet) ->
		[arg, expected] = testSet
		it "Move #{arg} to #{expected}", ->
			result = cal.applyHolidays (moment(arg).toDate()), 2, yes
			result = moment(result).format(FORMAT)
			assert.equal expected, result

describe "apply holidays for 1-day long offer-time", ->
	[
		['2014-12-24 01:00:00', '2014-12-30 00:00:00']
		['2014-12-24 15:00:00', '2014-12-30 00:00:00']
		['2014-12-23 01:00:00', '2014-12-29 01:00:00']
		['2014-12-23 15:00:00', '2014-12-29 15:00:00']
		['2014-12-22 01:00:00', '2014-12-23 01:00:00']
		['2014-12-22 15:00:00', '2014-12-23 15:00:00']
		['2014-12-21 01:00:00', '2014-12-23 00:00:00']
		['2014-12-21 15:00:00', '2014-12-23 00:00:00']

	].forEach (testSet) ->
		[arg, expected] = testSet
		it "Move #{arg} to #{expected}", ->
			expected = new Date expected

			result = cal.applyHolidays (moment(arg).toDate()), 1, yes

			assert.equal result.getTime(), expected.getTime(), "applyHolidays #{expected} not #{result}"

describe "apply holidays for 5-day long offer-time", ->
	[
		['2014-12-24 01:00:00', '2015-01-06 00:00:00']
		['2014-12-23 01:00:00', '2015-01-05 01:00:00']
		['2014-12-22 01:00:00', '2015-01-02 01:00:00']
		['2014-12-21 01:00:00', '2015-01-02 00:00:00']

		['2014-12-24 01:00:00', '2015-01-06 00:00:00']
		['2014-12-24 15:00:00', '2015-01-06 00:00:00']
		['2014-12-23 01:00:00', '2015-01-05 01:00:00']
		['2014-12-23 15:00:00', '2015-01-05 15:00:00']
		['2014-12-22 01:00:00', '2015-01-02 01:00:00']
		['2014-12-22 15:00:00', '2015-01-02 15:00:00']
		['2014-12-21 01:00:00', '2015-01-02 00:00:00']
		['2014-12-21 15:00:00', '2015-01-02 00:00:00']

	].forEach (testSet, idx) ->
		[arg, expected] = testSet
		it "Move #{arg} to #{expected}", ->
			expected = new Date expected

			result = cal.applyHolidays (moment(arg).toDate()), 5, yes

			assert.equal result.getTime(), expected.getTime(), "applyHolidays expected(#{idx}) #{expected} not #{result}"


