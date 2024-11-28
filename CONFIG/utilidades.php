<?php
// CONFIG/utilidades.php
function obtenerConexion() {
    include_once "../CONFIG/conexion.php"; // Respetamos tu configuración actual
    return $mysqli;
}

function ejecutarConsulta($sql, $parametros = []) {
    $conexion = obtenerConexion();
    $stmt = $conexion->prepare($sql);

    if ($parametros) {
        $tipos = str_repeat('s', count($parametros)); // Asumimos strings por defecto
        $stmt->bind_param($tipos, ...$parametros);
    }

    $stmt->execute();
    return $stmt->get_result(); // Retorna el resultado para procesar
}


?>
