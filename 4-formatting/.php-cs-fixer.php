<?php

$config = new PhpCsFixer\Config();

return $config->setRules([
	'@PhpCsFixer' => true,
	'indentation_type' => true,
	'single_quote' => true,
])
	->setIndent("\t")
	->setLineEnding("\n")
;
