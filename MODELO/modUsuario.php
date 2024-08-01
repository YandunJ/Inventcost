<?php
// MODELO/modUsuario.php

require_once "../CONFIG/conexion.php";

class Usuario {
    private $db;

    public function __construct() {
        $conexion = new Cls_DataConnection();
        $this->db = $conexion->FN_getConnect();
    }

    public function obtenerRoles() {
        $sql = "SELECT * FROM roles";
        $result = $this->db->query($sql);
        $roles = [];

        while ($row = $result->fetch_assoc()) {
            $roles[] = $row;
        }

        return $roles;
    }

    public function insertarUsuario($cedula, $nombre, $apellido, $telefono, $correo, $direccion, $usuario, $contrasenia, $rol_id) {
        $sql = "CALL sp_registrar_usuario(?, ?, ?, ?, ?, ?, ?, ?, ?)";
        $stmt = $this->db->prepare($sql);
        if ($stmt === false) {
            throw new Exception('Error en la preparación del statement: ' . $this->db->error);
        }
        $stmt->bind_param("ssssssssi", $cedula, $nombre, $apellido, $telefono, $correo, $direccion, $usuario, $contrasenia, $rol_id);
        $result = $stmt->execute();
        if ($result === false) {
            throw new Exception('Error en la ejecución del statement: ' . $stmt->error);
        }
        return $result;
    }
}
?>
