$( document ).ready(function() {
    var divtab = '<div style="width: 100%; display: table;">' +
	'<div style="display: table-row">'
    
    var fiveclogo = '<div style="width: 270px; display: table-cell;position:relative;float:left">'+
	'<a href="https://5c.careers/" target="_blank">' +
	'<img src="5clogo.jpg" height="75" align="left"></a></div>'

    var phszlogo = '<a href="https://www.phsz.ch/" target="_blank">' +
	'<img  src="phsz.jpg" height="30" align="right" style="margin-top:10px;margin-right:30px"></a></div>'

    var wulogo = '<div style="display: table-cell;position:relative;float:left;width:66\%">' +
	'<a href="https://www.wu.ac.at/" target="_blank">' +
	'<img src="wuwien.png" height="60" align="right" style="margin-top:10px"></a>'

    var divend = '</div></div>'

    $( "h2" ).replaceWith( divtab+fiveclogo+wulogo+phszlogo+divend );
});



//style="padding-bottom:77px; max-width:270px;"
//'<div style="padding-bottom:77px;width:90\%;">


