<?php
require_once('../vendor/autoload.php');
require_once("../CONFIG/conexion.php");
require_once("../MODELO/modKardex.php");

$kardex = new Kardex();

$categoria_id = $_GET['categoria_id'];
$fecha_inicio = $_GET['fecha_inicio'];
$fecha_fin = $_GET['fecha_fin'];

$data = $kardex->obtenerKardex($categoria_id, $fecha_inicio, $fecha_fin);

// Crear un nuevo documento PDF
$pdf = new TCPDF();

// Establecer la información del documento
$pdf->SetCreator(PDF_CREATOR);
$pdf->SetAuthor('FranFruit');
$pdf->SetTitle('Kardex de Inventario');
$pdf->SetSubject('Reporte de Kardex');
$pdf->SetKeywords('TCPDF, PDF, Kardex, Inventario');

// Establecer las márgenes
$pdf->SetMargins(PDF_MARGIN_LEFT, PDF_MARGIN_TOP, PDF_MARGIN_RIGHT);
$pdf->SetHeaderMargin(PDF_MARGIN_HEADER);
$pdf->SetFooterMargin(PDF_MARGIN_FOOTER);

// Establecer el auto-break de página
$pdf->SetAutoPageBreak(TRUE, PDF_MARGIN_BOTTOM);

// Añadir una página
$pdf->AddPage();

// Función para convertir el mes a español
function mesEnEspanol($mes) {
    $meses = [
        'January' => 'Enero',
        'February' => 'Febrero',
        'March' => 'Marzo',
        'April' => 'Abril',
        'May' => 'Mayo',
        'June' => 'Junio',
        'July' => 'Julio',
        'August' => 'Agosto',
        'September' => 'Septiembre',
        'October' => 'Octubre',
        'November' => 'Noviembre',
        'December' => 'Diciembre'
    ];
    return $meses[$mes];
}

// Obtener el mes en español
$mes = mesEnEspanol(date('F', strtotime($fecha_inicio)));

// Calcular los totales
$totalEntradas = 0;
$totalSalidas = 0;
$totalSaldoFinal = 0;

foreach ($data as $row) {
    $totalEntradas += $row['Entradas'];
    $totalSalidas += $row['Salidas'];
    $totalSaldoFinal += $row['Saldo_Final'];
}

// Establecer el contenido del PDF
$html = '<h1>RESUMEN DE SALDOS Y MOVIMIENTOS DE PRODUCTOS DEL MES DE ' . strtoupper($mes) . ' DEL ' . date('Y', strtotime($fecha_inicio)) . '</h1>';
$html .= '<table border="1" cellpadding="4">';
$html .= '<thead>
            <tr>
                <th>Producto</th>
                <th>Presentación</th>
                <th>Saldo Inicial</th>
                <th>Entradas</th>
                <th>Salidas</th>
                <th>Saldo Final</th>
            </tr>
          </thead>';
$html .= '<tbody>';
foreach ($data as $row) {
    $html .= '<tr>
                <td>' . $row['Producto'] . '</td>
                <td>' . $row['Presentación'] . '</td>
                <td>' . $row['Saldo_Inicial'] . '</td>
                <td>' . $row['Entradas'] . '</td>
                <td>' . $row['Salidas'] . '</td>
                <td>' . $row['Saldo_Final'] . '</td>
              </tr>';
}
$html .= '</tbody>';
$html .= '<tfoot>
            <tr>
                <th colspan="3">Totales</th>
                <th>' . $totalEntradas . '</th>
                <th>' . $totalSalidas . '</th>
                <th>' . $totalSaldoFinal . '</th>
            </tr>
          </tfoot>';
$html .= '</table>';

// Escribir el contenido HTML en el PDF
$pdf->writeHTML($html, true, false, true, false, '');

// Salida del PDF
$pdf->Output('kardex_inventario.pdf', 'I');
?>