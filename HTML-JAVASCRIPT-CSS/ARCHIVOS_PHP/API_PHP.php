<?php
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json;charset=utf-8');
header('Access-Control-Allow-Headers: *');
require("CONEXION_BD.php");

class objetoGenerico
{
    public $_campo_1;
    public $_campo_2;
    public $_campo_3;
    public $_campo_4;
    public $_campo_5;

    public function __construct($campo_1, $campo_2, $campo_3, $campo_4, $campo_5)
    {
        $this->_campo_1 = $campo_1;
        $this->_campo_2 = $campo_2;
        $this->_campo_3 = $campo_3;
        $this->_campo_4 = $campo_4;
        $this->_campo_5 = $campo_5;
    }
}


if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if ($_GET["funcion"] == "registrarObjeto") {
        $jsonRecibido = file_get_contents("php://input");
        $arrayAsociativo = json_decode($jsonRecibido, true);
        $nuevoObjetoGenerico = new objetoGenerico($arrayAsociativo["campo_1"], $arrayAsociativo["campo_2"], $arrayAsociativo["campo_3"], $arrayAsociativo["campo_4"], $arrayAsociativo["campo_5"]);
        mysqli_query($mysqli, "INSERT INTO `tabla_1` (`ID`, `CAMPO_1`, `CAMPO_2`, `CAMPO_3`, `CAMPO_4`, `CAMPO_5`) VALUES (NULL, '$nuevoObjetoGenerico->_campo_1', '$nuevoObjetoGenerico->_campo_2', '$nuevoObjetoGenerico->_campo_3', '$nuevoObjetoGenerico->_campo_4', '$nuevoObjetoGenerico->_campo_5')");
        $jsonAEnviar = json_encode($nuevoObjetoGenerico);
        file_put_contents("php://output", $jsonAEnviar);
    }
}
if ($_SERVER["REQUEST_METHOD"] == "GET") {
    if ($_GET["funcion"] == "obtenerLista") {
        $pila = array();
        $resultado = mysqli_query($mysqli, "SELECT * FROM `tabla_1`");
        if ($resultado->num_rows > 0) {
            while ($registro = mysqli_fetch_assoc($resultado)) {
                array_push($pila, $registro);
            }
            file_put_contents("php://output", json_encode($pila));
        } else {
            file_put_contents("php://output", json_encode($pila));
        }
    }
}
//INSERT INTO `tabla_1` (`ID`, `CAMPO_1`, `CAMPO_2`, `CAMPO_3`, `CAMPO_4`, `CAMPO_5`) VALUES (NULL, 'ASD', 'ASD', 'ASD', 'ASD', 'ASD');