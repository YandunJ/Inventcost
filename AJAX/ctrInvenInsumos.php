<?php
//AJAX/ctrInventInsumos.php


require_once "../MODELO/modInvenInsumos.php";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $insumo_id = $_POST['insumo_id'];
    $proveedor_id = $_POST['proveedor_id'];
    $cantidad = $_POST['cantidad'];
    $precio_unitario = $_POST['precio_unitario'];

    $modelo = new modInventarioInsumos();
    $response = $modelo->registrarInventarioInsumos($insumo_id, $proveedor_id, $cantidad, $precio_unitario);

    echo json_encode($response);
}
?>
