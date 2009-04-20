<?php

include 'getIP.php';
$_SESSION['REMOTE_IP'] = getip();
//echo ini_get('include_path');
//echo $_SESSION['REMOTE_IP'];
print_r( $_SESSION);
echo session_id();
?>