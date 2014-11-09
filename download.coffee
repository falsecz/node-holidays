request = require 'request'
ical = require 'ical'
async = require 'async'
fs = require 'fs'
list = require './list'
list = list.filter (o) -> o.country
.map (o) ->
	country: o.country.toLowerCase(), key: encodeURIComponent (new Buffer o.did, "base64").toString()
async.eachSeries list, (cal, next) ->
	console.log "processing #{cal.country}"

	# console.log list
	# request = require 'request'
	# n = 'cs.czech%23holiday%40group.v.calendar.google.com'
	request " http://www.google.com/calendar/ical/#{cal.key}/public/basic.ics"
	, (err, pres, body) ->

		return console.log err if err
		cs = ical.parseICS body
		r = []
		for key, c of cs
			r.push
				start: c.start
				end: c.end
				name: c.summary
		fs.writeFile "#{__dirname}/data/#{cal.country}.json", JSON.stringify(r), next
, (err) ->
	return console.log err if err
	console.log "done"

# https://www.google.com/calendar/directory?did=holiday
#
#
# curl http://www.google.com/calendar/ical/czech__cs%40holiday.calendar.google.com/public/basic.ics?start-min=2015-01-01T00:00:00+01:00
#
#
# curl "http://www.google.com/calendar/ical/cs.czech%23holiday%40group.v.calendar.google.com/public/basic.ics?ctz=Europe%2FPrague&singleevents=true&start-min=2017-01-02T00%3A00%3A00%2B01%3A00&start-max=2017-02-06T00%3A00%3A00%2B01%3A00&max-results=1680&alt=json"
#
#  singleevents:true
#  start-min:2015-01-01
#  start-max:2016-10-03T00:00:00+01:00