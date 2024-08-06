<?php
// AJAX/ctrEmpleados.php
include_once '../CONFIG/conexion.php';
include_once '../MODELO/modEmpleados.php';

$database = new Cls_DataConnection();
$db = $database->FN_getConnect();
$empleado = new Empleados($db);

$action = isset($_POST['action']) ? $_POST['action'] : '';

switch ($action) {
    case 'addOrUpdateEmpleado':
        $emp_id = $_POST['emp_id'];
        $cedula = $_POST['cedula'];
        $nombre = $_POST['nombre'];
        $apellido = $_POST['apellido'];
        $telefono = $_POST['telefono'];
        $correo = $_POST['correo'];
        $direccion = $_POST['direccion'];

        $response = $empleado->addOrUpdateEmpleado($emp_id, $cedula, $nombre, $apellido, $telefono, $correo, $direccion);
        echo json_encode($response);
        break;

    case 'obtenerEmpleados':
        $response = $empleado->getEmpleados();
        echo json_encode($response);
        break;

    case 'getEmpleadoById':
        $emp_id = $_POST['emp_id'];
        $response = $empleado->getEmpleadoById($emp_id);
        echo json_encode($response);
        break;

    case 'deleteEmpleado':
        $emp_id = $_POST['emp_id'];
        $cedula = $_POST['cedula'];
        $response = $empleado->deleteEmpleado($emp_id, $cedula);
        echo json_encode($response);
        break;

    default:
        echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        break;
}
?>
