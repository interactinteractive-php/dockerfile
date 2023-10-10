<?php if (!defined('_VALID_PHP')) exit('Direct access to this location is not allowed.');
/**
 * Configuration
 *
 * @package IA PHPframework
 * @author  B.Och-Erdene
 */

define('URL', getenv('URL_PROTOCOL').$_SERVER['SERVER_NAME'].'/');
define('AUTH_URL', URL);
define('IS_AUTH_SERVER', true);

define('DS', DIRECTORY_SEPARATOR);
define('LIBS', 'libs'.DS);
define('UTILS', 'utils'.DS);
define('MD_LIB', 'middleware'.DS.'controllers'.DS);
define('IA_PROJECTS', 'projects'.DS.'controllers'.DS);

define('GF_SERVICE_ADDRESS', getenv('GF_SERVICE_ADDRESS'));
define('SERVICE_FULL_ADDRESS', getenv('SERVICE_FULL_ADDRESS'));

define('CACHE_PATH', getenv('CACHE_PATH'));

define('DB_HOST', getenv('DB_HOST'));
define('DB_NAME', getenv('DB_NAME'));
define('DB_USER', getenv('DB_USER'));
define('DB_PASS', getenv('DB_PASS'));
define('DB_SID', getenv('DB_SID'));
define('DB_DRIVER', getenv('DB_DRIVER'));
define('DB_DEBUG', false);
define('DB_CHATSET', 'utf8');
define('DB_COLLAT', 'utf8_unicode_ci');

define('ENVIRONMENT', 'production'); //production, development

define('SESSION_PREFIX', getenv('SESSION_PREFIX'));
define('SESSION_LIFETIME', getenv('SESSION_LIFETIME'));

define('UPLOADPATH', 'storage/uploads/');
define('CONFIG_TIMEZONE', getenv('CONFIG_TIMEZONE'));

define('CONFIG_META_IMPORT', getenv('CONFIG_META_IMPORT'));
define('CONFIG_TOP_MENU', true);
define('CONFIG_CHECK_UPDATE', true);

define('SMTP_HOST', getenv('SMTP_HOST'));
define('SMTP_PORT', getenv('SMTP_PORT'));
define('SMTP_USER', getenv('SMTP_USER'));
define('SMTP_PASS', getenv('SMTP_PASS'));
define('SMTP_SECURE', getenv('SMTP_SECURE'));
define('SMTP_AUTH', getenv('SMTP_AUTH'));
define('SMTP_SSL_VERIFY', getenv('SMTP_SSL_VERIFY'));
define('EMAIL_FROM', getenv('EMAIL_FROM'));
define('EMAIL_FROM_NAME', getenv('EMAIL_FROM_NAME'));

if ($CONFIG_FILE_VIEWER_ADDRESS = getenv('CONFIG_FILE_VIEWER_ADDRESS')) {
    define('CONFIG_FILE_VIEWER_ADDRESS', $CONFIG_FILE_VIEWER_ADDRESS);
}
if ($CONFIG_POSAPI_SERVICE_ADDRESS = getenv('CONFIG_POSAPI_SERVICE_ADDRESS')) {
    define('CONFIG_POSAPI_SERVICE_ADDRESS', $CONFIG_POSAPI_SERVICE_ADDRESS);
}
if ($CONFIG_REPORT_SERVER_ADDRESS = getenv('CONFIG_REPORT_SERVER_ADDRESS')) {
    define('CONFIG_REPORT_SERVER_ADDRESS', $CONFIG_REPORT_SERVER_ADDRESS);
}
if ($CONFIG_PIVOT_SERVICE_ADDRESS = getenv('CONFIG_PIVOT_SERVICE_ADDRESS')) {
    define('CONFIG_PIVOT_SERVICE_ADDRESS', $CONFIG_PIVOT_SERVICE_ADDRESS);
}

?>