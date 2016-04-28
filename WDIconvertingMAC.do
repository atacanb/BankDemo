*in Excel sheet rename years starting with y
	 gen id = _n
	 reshape long y, i(id) j(year)
	 encode  indicatorname, gen(varnum)
	 label save varnum using "/Users/AtaCan/Dropbox/Research/vardesc.do" ,  replace
	 

	 **
/**The "label save" command creates vardesc.do, a do file for applying the WDI series descriptors as labels 
to values of the "varnum" variable. We are going to turn each different value of varnum (each WDI series) into a variable. 
To keep track of which variable holds the data for which series, we will turn vardesc.do into a program for applying the series descriptors 
to the variables as variable labels. To do this, edit vardesc.do in Word or another editor so each line has the form:
label var data1 `"Adjusted savings: adjusted net savings (% of GNI)"'
To do that replace "define varnum " by "var data" and ", modify" by ""

 ***/


	   drop id  indicatorname
	 rename y data
	 egen id = group( wbcode year)
	 reshape wide data, i(id) j(varnum)
	 
	 do "./Research/vardesc.do"
drop id
sort wbcode year
save "./Research/JMpaper/Data/MacroData/AdditionalWDI19982011.dta", replace

merge wbcode using "./Research/JMpaper/Data/MacroData/wbcode.dta"

drop if _m!=3

 save "./Research/JMpaper/Data/MacroData/DoingBusinessWarehouse.dta", replace
