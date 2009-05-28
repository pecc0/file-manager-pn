<?php
	if (ereg("MSIE" ,$_SERVER['HTTP_USER_AGENT'])) {
		//in case of internet explorer-don't cahche the contents
		session_cache_limiter('public');
	}
	session_start();
?>