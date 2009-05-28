<?php
	//echo 'secure works!<br/>';
	//echo '$_REQUEST ';
	//print_r($_SERVER);
	//print_r($_ENV);
	//header("Cache-Control: no-store");
	include 'securedHeader.php';
	//php faila trqbva da e izvikan s absoliuten pyt (e.x. https://localhost/secure/index/php)
	echo SID;
	
	//echo (include 'texts.php');
	
?>