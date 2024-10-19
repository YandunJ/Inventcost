<?php
//MODELO/modProveedores.php

class Proveedores {
    private $db;

    public function __construct($db) {
        $this->db = $db;
    }

    public function acciones_proveedor($proveedor_id, $nombre_empresa, $representante, $direccion, $correo, $telefono) {
        $stmt = $this->db->prepare("CALL acciones_proveedor(?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("isssss", $proveedor_id, $nombre_empresa, $representante, $direccion, $correo, $telefono);
        if (!$stmt->execute()) {
            throw new Exception($stmt->error); // Lanza una excepción si hay un error
        }
        return true;
    }
    

    public function pa_obtener_proveedores() {
        $result = $this->db->query("CALL pa_obtener_proveedores()");
        return $result->fetch_all(MYSQLI_ASSOC);
    }

    public function pa_eliminar_proveedor($proveedor_id) {
        $stmt = $this->db->prepare("CALL pa_eliminar_proveedor(?)");
        $stmt->bind_param("i", $proveedor_id);
        return $stmt->execute();
    }

    public function pa_obt_prov_id($proveedor_id) {
        $stmt = $this->db->prepare("CALL pa_obt_prov_id(?)");
        $stmt->bind_param("i", $proveedor_id);
        $stmt->execute();
        return $stmt->get_result()->fetch_assoc();
    }
}
?>

