<?php

namespace Valet\Drivers\Custom;

use Valet\Drivers\BasicValetDriver;

class WordPressMultisiteSubdirectoryValetDriver extends BasicValetDriver
{
	public $wp_root = false; // "wp"

	/**
	 * Determine if the driver serves the request.
	 */
	public function serves(string $sitePath, string $siteName, string $uri): bool
	{
		// Look for MULTISITE in wp-config.php. It should be there for multisite installs.
		return file_exists($sitePath.'/wp-config.php')
			&& (false !== strpos(file_get_contents($sitePath.'/wp-config.php'), 'MULTISITE'))
			&& (
				// Double check if we are using subdomains.
				strpos(file_get_contents($sitePath.'/wp-config.php'), "define('SUBDOMAIN_INSTALL',false)")
				|| strpos(file_get_contents($sitePath.'/wp-config.php'), "define('SUBDOMAIN_INSTALL', false)")
				|| strpos(file_get_contents($sitePath.'/wp-config.php'), "define( 'SUBDOMAIN_INSTALL', false )")
			);
	}

	/**
	 * Get the fully resolved path to the application's front controller.
	 */
	public function frontControllerPath(string $sitePath, string $siteName, string $uri): string
	{
		$_SERVER['PHP_SELF'] = $uri;
		$_SERVER['SERVER_ADDR'] = '127.0.0.1';
		$_SERVER['SERVER_NAME'] = $_SERVER['HTTP_HOST'];

		// If URI contains one of the main WordPress directories, and it's not a request for the Network Admin,
		// drop the subdirectory segment before routing the request
		if (false !== stripos($uri, 'wp-admin') || false !== stripos($uri, 'wp-content') || false !== stripos($uri, 'wp-includes')) {
			if (false === stripos($uri, 'wp-admin/network')) {
				$uri = substr($uri, stripos($uri, '/wp-'));
			}

			if (false !== $this->wp_root && file_exists($sitePath."/{$this->wp_root}/wp-admin")) {
				$uri = "/{$this->wp_root}".$uri;
			}
		}

		// Handle wp-cron.php properly
		if (false !== stripos($uri, 'wp-cron.php')) {
			$new_uri = substr($uri, stripos($uri, '/wp-'));

			if (file_exists($sitePath.$new_uri)) {
				return $sitePath.$new_uri;
			}
		}

		return parent::frontControllerPath(
			$sitePath,
			$siteName,
			$this->forceTrailingSlash($uri)
		);
	}

	/**
	 * Determine if the incoming request is for a static file.
	 */
	public function isStaticFile(string $sitePath, string $siteName, string $uri)// : string|false
	{
		// If the URI contains one of the main WordPress directories and it doesn't end with a slash,
		// drop the subdirectory from the URI and check if the file exists. If it does, return the new uri.
		if (false !== stripos($uri, 'wp-admin') || false !== stripos($uri, 'wp-content') || false !== stripos($uri, 'wp-includes')) {
			if ('/' == substr($uri, -1, 1)) {
				return false;
			}

			$new_uri = substr($uri, stripos($uri, '/wp-'));

			if (false !== $this->wp_root && file_exists($sitePath."/{$this->wp_root}/wp-admin")) {
				$new_uri = "/{$this->wp_root}".$new_uri;
			}

			if (file_exists($sitePath.$new_uri)) {
				return $sitePath.$new_uri;
			}
		}

		return parent::isStaticFile($sitePath, $siteName, $uri);
	}

	/**
	 * Redirect to uri with trailing slash.
	 */
	private function forceTrailingSlash(string $uri): string
	{
		if ('/wp-admin' == substr($uri, -1 * strlen('/wp-admin'))) {
			header('Location: '.$uri.'/');

			exit;
		}

		return $uri;
	}
}
