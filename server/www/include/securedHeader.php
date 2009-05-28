<?php
	//the AIR sends "Mozilla/5.0 (Windows; U; en) AppleWebKit/420+ (KHTML, like Gecko) AdobeAIR/1.0"
	if (ereg("MSIE" ,$_SERVER['HTTP_USER_AGENT'])) {
		//in case of internet explorer-don't cahche the contents
		session_cache_limiter('public');
	}
	session_start();
?>