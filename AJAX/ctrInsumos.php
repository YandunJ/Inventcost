<?php
//AJAX/ctrInsumos.php

error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "../MODELO/modInsumos.php";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $nombre = $_POST['nombre'];
    $descripcion = $_POST['descripcion'];
    $unidad_medida = $_POST['unidad_medida'];

    $insumo = new Insumo();
    $result = $insumo->registrarInsumo($nombre, $descripcion, $unidad_medida);

    if ($result) {
        echo json_encode(["success" => true]);
    } else {
        echo json_encode(["success" => false, "message" => "Error al registrar el insumo"]);
    }
}
?>
