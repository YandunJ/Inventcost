<?php
// MODELO/modEmpleados.php
class Empleados {
    private $conn;

    public function __construct($db) {
        $this->conn = $db;
    }

    public function addOrUpdateEmpleado($emp_id, $cedula, $nombre, $apellido, $telefono, $correo, $direccion) {
        try {
            $query = "CALL acciones_empleado(?, ?, ?, ?, ?, ?, ?)";
            $stmt = $this->conn->prepare($query);
            $stmt->bind_param("issssss", $emp_id, $cedula, $nombre, $apellido, $telefono, $correo, $direccion);
            $stmt->execute();
            return ['status' => 'success', 'message' => 'Empleado registrado o actualizado correctamente.'];
        } catch (Exception $e) {
            return ['status' => 'error', 'message' => $e->getMessage()];
        }
    }

    public function getEmpleados() {
        $query = "CALL pa_obt_empleados()";
        $result = $this->conn->query($query);
        $data = [];

        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }

        return ['status' => 'success', 'data' => $data];
    }

    public function getEmpleadoById($emp_id) {
        $query = "SELECT * FROM empleados WHERE emp_id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $emp_id);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            return ['status' => 'success', 'data' => $result->fetch_assoc()];
        } else {
            return ['status' => 'error', 'message' => 'Empleado no encontrado.'];
        }
    }

    public function deleteEmpleado($emp_id, $cedula) {
        try {
            $query = "CALL pa_eliminar_empleado(?, ?)";
            $stmt = $this->conn->prepare($query);
            $stmt->bind_param("is", $emp_id, $cedula);
            $stmt->execute();
            if ($stmt->affected_rows > 0) {
                return ['status' => 'success', 'message' => 'Empleado eliminado correctamente.'];
            } else {
                return ['status' => 'error', 'message' => 'No se puede eliminar un empleado que también es usuario.'];
            }
        } catch (Exception $e) {
            return ['status' => 'error', 'message' => $e->getMessage()];
        }
    }
}
?>
