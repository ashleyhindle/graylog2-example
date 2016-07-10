<?php
require_once 'vendor/autoload.php';

use Monolog\Logger;
use Monolog\Handler\GelfHandler;
use Gelf\Publisher;
use Gelf\Message;
use Gelf\Transport\UdpTransport;

$message = (isset($argv[1])) ? $argv[1] : 'Everything is awesome when we\'re living our dream';
$graylogServer = (isset($argv[2])) ? $argv[2] : 'dry-autumn-2579-194.fodor.xyz';

$transport = new UdpTransport($graylogServer, 5555);
$publisher = new Publisher($transport);
$gelfHandler = new GelfHandler($publisher);

$log = new Logger('Lego');
$log->pushHandler($gelfHandler);
$log->addWarning('Warning: ' . $message);
$log->addError('Error: ' . $message);
$log->addInfo('Info: ' . $message);
$log->addDebug('Debug: ' . $message);

echo 'Done and dusted' . PHP_EOL;
