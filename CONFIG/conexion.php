<?php
// CONFIG/conexion.php

require_once "global.php";

class Cls_DataConnection {
    function FN_getConnect() {
        if (!($conexion1 = new MySQLi(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME))) {
            echo "Error al conectar la base de datos";
            exit();
        }

        return $conexion1;
    }
}

if (!function_exists('ejecutarConsultaSP')) {
    function ejecutarConsultaSP($sql) {
        $Fn = new Cls_DataConnection();
        $Cn = $Fn->FN_getConnect();
        $query = $Cn->query($sql);
        $Cn->close();
        return $query;
    }
}
?>
