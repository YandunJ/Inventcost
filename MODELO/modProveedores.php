<?php
//MODELO/modProveedores.php
require_once __DIR__ . "/../CONFIG/conexion.php";

class Proveedores {
    private $conn;
    private $table_name = "proveedores";

    public function __construct($db) {
        $this->conn = $db;
    }

    public function guardarDatos($nombre_empresa, $representante, $direccion, $correo, $telefono) {
        $query = "INSERT INTO " . $this->table_name . " (nombre_empresa, representante, direccion, correo, telefono) VALUES (?, ?, ?, ?, ?)";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("sssss", $nombre_empresa, $representante, $direccion, $correo, $telefono);

        if ($stmt->execute()) {
            return array("status" => "success");
        } else {
            return array("status" => "error", "message" => $stmt->error);
        }
    }

    public function actualizarDatos($proveedor_id, $nombre_empresa, $representante, $direccion, $correo, $telefono) {
        $query = "UPDATE " . $this->table_name . " SET nombre_empresa = ?, representante = ?, direccion = ?, correo = ?, telefono = ? WHERE proveedor_id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("sssssi", $nombre_empresa, $representante, $direccion, $correo, $telefono, $proveedor_id);

        if ($stmt->execute()) {
            return array("status" => "success");
        } else {
            return array("status" => "error", "message" => $stmt->error);
        }
    }

    public function eliminarDatos($proveedor_id) {
        $query = "DELETE FROM " . $this->table_name . " WHERE proveedor_id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $proveedor_id);

        if ($stmt->execute()) {
            return array("status" => "success");
        } else {
            return array("status" => "error", "message" => $stmt->error);
        }
    }

    public function obtenerProveedores() {
        $query = "SELECT * FROM " . $this->table_name;
        $result = $this->conn->query($query);
        $data = array();

        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }

        return array("status" => "success", "data" => $data);
    }

    public function obtenerProveedor($proveedor_id) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE proveedor_id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $proveedor_id);
        $stmt->execute();
        $result = $stmt->get_result();
        $data = $result->fetch_assoc();

        if ($data) {
            return array("status" => "success", "data" => $data);
        } else {
            return array("status" => "error", "message" => "Proveedor no encontrado");
        }
    }
}
?>
