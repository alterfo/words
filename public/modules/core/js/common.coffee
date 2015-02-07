Date.prototype.yyyymm = ->
	yyyy = this.getFullYear().toString()
	mm = (this.getMonth()+1).toString()
	yyyy + (if mm.length == 2 then mm else "0" + mm)

Date.prototype.yyyymmdd = ->
	yyyy = this.getFullYear().toString()
	mm = (this.getMonth()+1).toString()
	dd  = this.getDate().toString();
	yyyy + (if mm.length == 2 then mm else "0" + mm) + (if dd.length == 2 then dd else "0" + dd)

Date.prototype.nextMonth = ->
	new Date(this.setMonth(this.getMonth() + 1))

Date.prototype.prevMonth = ->
	new Date(this.setMonth(this.getMonth() - 1))

daysInMonth = (month,year) ->
	return new Date(year, month, 0).getDate()