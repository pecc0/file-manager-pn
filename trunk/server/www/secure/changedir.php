<?php
include 'securedHeader.php';
include 'constants.php';
$user = $_SESSION['UNAME'];
if ($user == '') {
	echo "error:userNotLogged";
	die;
}

$path = realpath($usersHome . '/' . $user . '/' . $_POST["dir"]);
$userPath = realpath($usersHome . '/' . $user);
if (substr_compare($userPath, $path, 0, strlen($userPath)) != 0) {
	echo "error:" . $userPath . "!=" . $path;
	die;
}

chdir($path);

include 'xmlUtils.php';

$doc = new DOMDocument();
// we want a nice output
$doc->formatOutput = true;

$root = $doc->createElement("DirListing");
$root = $doc->appendChild($root);
addAttribute($doc, $root, 'username1', $user);

$dirs = array_diff( scandir( $path ), Array( ".", ".." ) );

foreach( $dirs as $d ){
	if (!ereg("^\..*$", $d)) {
		if( is_dir($path."/".$d) ) {
			$subnode = $doc->createElement("dir");
			$emptyFile = $doc->createElement("file");
			$subnode->appendChild($emptyFile);
			addAttribute($doc, $emptyFile, "name", "loading...");
			addAttribute($doc, $subnode, "isBranch", "true");
			//$doc->createAttribute('username')
		} else {
			$subnode = $doc->createElement("file");
		}
		addAttribute($doc, $subnode, "name", $d);
		$root->appendChild($subnode);
	}
}

print $doc->saveXML(); 
?>
