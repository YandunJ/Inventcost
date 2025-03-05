<?php
require_once('../vendor/autoload.php');
require_once("../CONFIG/conexion.php");
require_once("../MODELO/modVentaPT.php");

$ventaPT = new VentaPT();

$despacho = json_decode($_GET['despacho'], true);
$precio_total = $_GET['precio_total'];

// Crear un nuevo documento PDF
$pdf = new TCPDF();

// Establecer la información del documento
$pdf->SetCreator(PDF_CREATOR);
$pdf->SetAuthor('FranFruit');
$pdf->SetTitle('Comprobante de Salida');
$pdf->SetSubject('Comprobante de Salida de Producto Terminado');
$pdf->SetKeywords('TCPDF, PDF, Comprobante, Salida, Producto Terminado');

// Establecer las márgenes
$pdf->SetMargins(PDF_MARGIN_LEFT, PDF_MARGIN_TOP, PDF_MARGIN_RIGHT);
$pdf->SetHeaderMargin(PDF_MARGIN_HEADER);
$pdf->SetFooterMargin(PDF_MARGIN_FOOTER);

// Establecer el auto-break de página
$pdf->SetAutoPageBreak(TRUE, PDF_MARGIN_BOTTOM);

// Añadir una página
$pdf->AddPage();

// Establecer el contenido del PDF
$html = '<h1>Comprobante de Salida</h1>';
$html .= '<p>Fecha: ' . date('d/m/Y') . '</p>';
$html .= '<table border="1" cellpadding="4">';
$html .= '<thead>
            <tr>
                <th>ID Producto</th>
                <th>Lote</th>
                <th>Cantidad Despachada</th>
                <th>Precio Unitario</th>
                <th>Precio Total</th>
            </tr>
          </thead>';
$html .= '<tbody>';
foreach ($despacho as $item) {
    $html .= '<tr>
                <td>' . $item['id_pt'] . '</td>
                <td>' . $item['lote'] . '</td>
                <td>' . $item['cantidad_despachada'] . '</td>
                <td>' . $item['precio_unitario'] . '</td>
                <td>' . ($item['cantidad_despachada'] * $item['precio_unitario']) . '</td>
              </tr>';
}
$html .= '</tbody>';
$html .= '<tfoot>
            <tr>
                <th colspan="4">Precio Total de la Salida</th>
                <th>' . $precio_total . '</th>
            </tr>
          </tfoot>';
$html .= '</table>';

// Escribir el contenido HTML en el PDF
$pdf->writeHTML($html, true, false, true, false, '');

// Salida del PDF
$pdf->Output('comprobante_salida.pdf', 'I');
?>