<?php
include 'securedHeader.php';
include 'constants.php';
include 'loginCheck.php';

$userDir=$usersHome . '/' . $_SESSION['UNAME'];
chdir($userDir);
$doc = new DOMDocument();
$doc->load($confXml);
$xp = new DOMXPath($doc);
if (isset($_POST['WallPaper'])) {
	echo 'WallPaper ' .  $_POST['WallPaper'];
	$wp = $xp->evaluate("/UserConf/WallPaper")->item(0);
	$wp->removeChild($wp->firstChild);
	$wp->appendChild($doc->createTextNode($_POST['WallPaper']));
}
$doc->save($confXml);
?>