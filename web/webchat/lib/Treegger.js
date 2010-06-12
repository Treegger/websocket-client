
google.load("jquery", "1.4");
google.load("jqueryui", "1.8");

google.setOnLoadCallback(function() 
{
	$("#dialog").dialog(
	{
		width: 140,
		height: 400,
		closeOnEscape: false
	}
	) ;
	
	
	$("#b1").dblclick( function() { alert("Blabla" ) })
});

