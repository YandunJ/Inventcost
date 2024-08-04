<?php
//AJAX/ctrProveedores.php

include_once '../CONFIG/conexion.php';
include_once '../MODELS/modEmpleados.php';

$database = new Database();
$db = $database->getConnection();
$empleado = new Empleados($db);

$action = isset($_POST['action']) ? $_POST['action'] : '';

switch ($action) {
    case 'addEmpleado':
        $cedula = $_POST['cedula'];
        $nombre = $_POST['nombre'];
        $apellido = $_POST['apellido'];
        $telefono = $_POST['telefono'];
        $correo = $_POST['correo'];
        $direccion = $_POST['direccion'];

        $response = $empleado->addOrUpdateEmpleado(null, $cedula, $nombre, $apellido, $telefono, $correo, $direccion);

        if ($response) {
            echo json_encode(['status' => 'success']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'No se pudo agregar el empleado.']);
        }
        break;

    case 'updateEmpleado':
        $emp_id = $_POST['emp_id'];
        $cedula = $_POST['cedula'];
        $nombre = $_POST['nombre'];
        $apellido = $_POST['apellido'];
        $telefono = $_POST['telefono'];
        $correo = $_POST['correo'];
        $direccion = $_POST['direccion'];

        $response = $empleado->addOrUpdateEmpleado($emp_id, $cedula, $nombre, $apellido, $telefono, $correo, $direccion);

        if ($response) {
            echo json_encode(['status' => 'success']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'No se pudo actualizar el empleado.']);
        }
        break;

    case 'deleteEmpleado':
        $emp_id = $_POST['emp_id'];
        $cedula = $_POST['cedula'];

        $response = $empleado->deleteEmpleado($emp_id, $cedula);

        if ($response) {
            echo json_encode(['status' => 'success']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'No se pudo eliminar el empleado.']);
        }
        break;

    case 'obtenerEmpleados':
        $stmt = $empleado->obtenerEmpleados();
        $num = $stmt->rowCount();

        if ($num > 0) {
            $empleados_arr = array();
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                extract($row);
                $empleado_item = array(
                    "emp_id" => $emp_id,
                    "emp_cedula" => $emp_cedula,
                    "emp_nombre" => $emp_nombre,
                    "emp_apellido" => $emp_apellido,
                    "emp_telefono" => $emp_telefono,
                    "emp_correo" => $emp_correo,
                    "emp_direccion" => $emp_direccion
                );
                array_push($empleados_arr, $empleado_item);
            }
            echo json_encode(['data' => $empleados_arr]);
        } else {
            echo json_encode(['data' => []]);
        }
        break;

    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida.']);
        break;
}
?>
