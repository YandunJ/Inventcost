<?php
// CONFIG/conexion.php
require_once "../CONFIG/global.php";

class Cls_DataConnection {
    public function FN_getConnect() {
        $conexion = new MySQLi(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME);
        if ($conexion->connect_error) {
            die("Error al conectar la base de datos: " . $conexion->connect_error);
        }
        return $conexion;
    }

    public function ejecutarSP($query, $params = []) {
        $conexion = $this->FN_getConnect();
        $stmt = $conexion->prepare($query);

        if (!$stmt) {
            die("Error al preparar la consulta: " . $conexion->error);
        }

        if ($params) {
            $tipos = str_repeat('s', count($params)); // Asumimos que todos son strings
            $stmt->bind_param($tipos, ...$params);
        }

        if (!$stmt->execute()) {
            die("Error al ejecutar la consulta: " . $stmt->error);
        }

        $result = $stmt->get_result();
        $stmt->close();
        $conexion->close();

        return $result;
    }
}
?>
