node-holidays
=============

```coffee
cal = holidays.locale 'cz'
console.log JSON.stringify cal.find new Date "2015-09-28T00:00:00.000"
# {"start":"2015-09-27T22:00:00.000Z","end":"2015-09-28T22:00:00.000Z","name":"Den české státnosti"}

console.log cal.findAfter new Date "2014-12-24T21:59:00.000"
# Sat Dec 27 2014 00:00:01 GMT+0100 (CET)
```
