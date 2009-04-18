<?php
include 'getIP.php';
$_SESSION['REMOTE_IP'] = getip();
echo $_SESSION['REMOTE_IP'];

?>