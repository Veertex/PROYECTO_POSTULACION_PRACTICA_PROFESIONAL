<?php
$direccion="127.0.0.1";
$puerto=3306;
$usuario="root";
$contraseña="";
$base_de_datos="test";

$mysqli = new mysqli($direccion, $usuario, $contraseña, $base_de_datos, $puerto);

?>