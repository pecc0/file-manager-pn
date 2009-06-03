<?php
function addAttribute($doc, $root, $name, $value) {
	$userAttr = $doc->createAttribute($name);
	$root->appendChild($userAttr);
	$userAttr->appendChild($doc->createTextNode($value));
}
?>