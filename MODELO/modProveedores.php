<?php
// MODELO/modProveedores.php

class Proveedores {
    private $conn;

    public function __construct() {
        $conexion = new Cls_DataConnection();
        $this->conn = $conexion->FN_getConnect();
    }

    // CRUD para Proveedores (Insertar, Actualizar, Eliminar)
    public function prov_CRUD($accion, $proveedor_id, $nombre_empresa, $representante, $correo, $telefono) {
        $stmt = $this->conn->prepare("CALL prov_CRUD(?, ?, ?, ?, ?, ?)");
        $stmt->bind_param('sissss', $accion, $proveedor_id, $nombre_empresa, $representante, $correo, $telefono);
        $result = $stmt->execute();
        $stmt->close();

        return $result;
    }

    // Eliminar un proveedor
    public function prov_eliminar($proveedor_id) {
        $stmt = $this->conn->prepare("CALL prov_eliminar(?)");
        $stmt->bind_param('i', $proveedor_id);
        $result = $stmt->execute();
        $stmt->close();

        return $result;
    }

    // Obtener todos los proveedores
    public function prov_datos() {
        $stmt = $this->conn->prepare("CALL prov_datos()");
        $stmt->execute();
        $result = $stmt->get_result();
        $data = $result->fetch_all(MYSQLI_ASSOC);
        $stmt->close();

        return $data;
    }

    // Obtener datos de un proveedor por ID
    public function prov_datos_id($proveedor_id) {
        $stmt = $this->conn->prepare("CALL prov_datos_id(?)");
        $stmt->bind_param('i', $proveedor_id);
        $stmt->execute();
        $result = $stmt->get_result();
        $data = $result->fetch_assoc();
        $stmt->close();

        return $data;
    }

    // Habilitar o deshabilitar un proveedor
    public function prov_toggle_status($proveedor_id, $estado) {
        $stmt = $this->conn->prepare("CALL prov_toggle_status(?, ?)");
        $stmt->bind_param('is', $proveedor_id, $estado);
        $result = $stmt->execute();
        $stmt->close();

        return $result;
    }
}
?>