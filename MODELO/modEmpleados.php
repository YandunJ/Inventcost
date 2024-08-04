<?php
//MODELO/modProveedores.php
class Empleados {
    private $conn;
    private $table_name = "empleados";

    public function __construct($db) {
        $this->conn = $db;
    }

    public function addOrUpdateEmpleado($emp_id, $cedula, $nombre, $apellido, $telefono, $correo, $direccion) {
        $query = "CALL acciones_empleado(?, ?, ?, ?, ?, ?, ?)";
        $stmt = $this->conn->prepare($query);
    
        // sanitize
        $cedula = htmlspecialchars(strip_tags($cedula));
        $nombre = htmlspecialchars(strip_tags($nombre));
        $apellido = htmlspecialchars(strip_tags($apellido));
        $telefono = htmlspecialchars(strip_tags($telefono));
        $correo = htmlspecialchars(strip_tags($correo));
        $direccion = htmlspecialchars(strip_tags($direccion));
    
        // bind new values
        $stmt->bindParam(1, $emp_id, PDO::PARAM_INT);
        $stmt->bindParam(2, $cedula);
        $stmt->bindParam(3, $nombre);
        $stmt->bindParam(4, $apellido);
        $stmt->bindParam(5, $telefono);
        $stmt->bindParam(6, $correo);
        $stmt->bindParam(7, $direccion);
    
        if ($stmt->execute()) {
            return true;
        }
        return false;
    }

    public function deleteEmpleado($emp_id, $cedula) {
        $query = "CALL acciones_empleado(?, ?, NULL, NULL, NULL, NULL, NULL)";
        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(1, $emp_id, PDO::PARAM_INT);
        $stmt->bindParam(2, $cedula);

        if ($stmt->execute()) {
            return true;
        }
        return false;
    }

    public function obtenerEmpleados() {
        $query = "SELECT * FROM " . $this->table_name;
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }
}
?>
