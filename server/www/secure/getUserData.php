<?php
include 'securedHeader.php';
include 'loginCheck.php';
include 'constants.php';
$userDir=$usersHome . '/' . $_SESSION['UNAME'];
chdir($userDir);
$doc = new DOMDocument();
$doc->load($confXml);
$xp = new DOMXPath($doc);
$pass = $xp->evaluate("/UserConf/Pass")->item(0);
error_log(print_r($pass, true));
$pass->parentNode->removeChild($pass);
$doc->formatOutput = true;
print $doc->saveXML();

?>