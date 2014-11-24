assert = require 'assert'
holidays = require '../'

process.env.TZ = "Europe/Prague"

cal = holidays.locale 'cz'

xdescribe "ranging Den české státnosti", ->

	[
		"2015-09-28T01:00:00.000Z"
		"2015-09-28T00:00:00.000Z"
		"2015-09-28T21:59:00.000Z"
	].forEach (d) ->
		it d, -> assert.equal cal.find(new Date d).name, 'Den české státnosti'

xdescribe "ranging outside holiday", ->
	[
		"2015-09-27T21:59:00.000Z"
		"2015-09-29T02:00:00.000Z"
	].forEach (d) ->
		it d, -> assert.equal cal.find(new Date d), false, 'nejsou svatky'

xdescribe "find after", ->
	[
		["2015-12-15T00:00:00.000Z", "2015-12-15T00:00:00.000Z"]
		["2015-09-28T21:59:00.000Z", "2015-09-28T22:00:01.000Z"]
		["2014-12-24T21:59:00.000Z", "2014-12-26T23:00:01.000Z"]
	].forEach (testSet, idx) ->
		[arg, expected] = testSet
		it "Move #{arg} to #{expected}", ->
			result = cal.findAfter(new Date arg).toISOString()
			assert.equal result, expected, "findAfter expected(#{idx}) #{expected} not #{result}"

describe "apply holidays for 2-day long offer-time", ->
	[
		['2014-12-24T01:00:00.000Z', '2014-12-31T00:00:00.000Z']
		['2014-12-24T15:00:00.000Z', '2014-12-31T00:00:00.000Z']
		['2014-12-23T01:00:00.000Z', '2014-12-30T01:00:00.000Z']
		['2014-12-23T15:00:00.000Z', '2014-12-30T15:00:00.000Z']
		['2014-12-22T01:00:00.000Z', '2014-12-29T01:00:00.000Z']
		['2014-12-22T15:00:00.000Z', '2014-12-29T15:00:00.000Z']
		['2014-12-21T01:00:00.000Z', '2014-12-23T01:00:00.000Z']
		['2014-12-21T15:00:00.000Z', '2014-12-23T15:00:00.000Z']

	].forEach (testSet, idx) ->
		[arg, expected] = testSet
		it "Move #{arg} to #{expected}", ->
			expected = new Date expected

			result = cal.applyHolidays (new Date arg), 2

			assert.equal result.getTime(), expected.getTime(), "applyHolidays expected(#{idx}) #{expected} not #{result}"

describe "apply holidays for 1-day long offer-time", ->
	[
		['2014-12-24T01:00:00.000Z', '2014-12-30T00:00:00.000Z']
		['2014-12-24T15:00:00.000Z', '2014-12-30T00:00:00.000Z']
		['2014-12-23T01:00:00.000Z', '2014-12-29T01:00:00.000Z']
		['2014-12-23T15:00:00.000Z', '2014-12-29T15:00:00.000Z']
		['2014-12-22T01:00:00.000Z', '2014-12-23T01:00:00.000Z']
		['2014-12-22T15:00:00.000Z', '2014-12-23T15:00:00.000Z']
		['2014-12-21T01:00:00.000Z', '2014-12-22T01:00:00.000Z']
		['2014-12-21T15:00:00.000Z', '2014-12-22T15:00:00.000Z']

	].forEach (testSet, idx) ->
		[arg, expected] = testSet
		it "Move #{arg} to #{expected}", ->
			expected = new Date expected

			result = cal.applyHolidays (new Date arg), 1

			assert.equal result.getTime(), expected.getTime(), "applyHolidays expected(#{idx}) #{expected} not #{result}"

describe "apply holidays for 5-day long offer-time", ->
	[
		['2014-12-24T01:00:00.000Z', '2015-01-06T01:00:00.000Z']
		['2014-12-23T01:00:00.000Z', '2015-01-05T01:00:00.000Z']
		['2014-12-22T01:00:00.000Z', '2015-01-02T01:00:00.000Z']
		['2014-12-21T01:00:00.000Z', '2014-12-23T01:00:00.000Z']

		['2014-12-24T01:00:00.000Z', '2015-01-06T00:00:00.000Z']
		['2014-12-24T15:00:00.000Z', '2015-01-06T00:00:00.000Z']
		['2014-12-23T01:00:00.000Z', '2015-01-05T01:00:00.000Z']
		['2014-12-23T15:00:00.000Z', '2015-01-05T15:00:00.000Z']
		['2014-12-22T01:00:00.000Z', '2015-01-02T01:00:00.000Z']
		['2014-12-22T15:00:00.000Z', '2015-01-02T15:00:00.000Z']
		['2014-12-21T01:00:00.000Z', '2015-01-02T00:00:00.000Z']
		['2014-12-21T15:00:00.000Z', '2015-01-02T00:00:00.000Z']

	].forEach (testSet, idx) ->
		[arg, expected] = testSet
		it "Move #{arg} to #{expected}", ->
			expected = new Date expected

			result = cal.applyHolidays (new Date arg), 5

			assert.equal result.getTime(), expected.getTime(), "applyHolidays expected(#{idx}) #{expected} not #{result}"


