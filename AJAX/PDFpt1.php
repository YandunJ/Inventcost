<?php
require('../fpdf/fpdf.php');
require_once "../CONFIG/conexion.php";
require_once "../MODELO/modProducto.php";

class PDF extends FPDF {
    // Cabecera de página
    function Header() {
        // Logo
        $this->Image('../FILES/fran2.png',10,8,33);
        // Arial bold 15
        $this->SetFont('Arial','B',15);
        // Movernos a la derecha
        $this->Cell(80);
        // Título
        $this->Cell(30,10,'Reporte de Lotes de Producto Terminado',0,1,'C');
        // Salto de línea
        $this->Ln(20);
    }

    // Pie de página
    function Footer() {
        // Posición: a 1,5 cm del final
        $this->SetY(-15);
        // Arial italic 8
        $this->SetFont('Arial','I',8);
        // Número de página
        $this->Cell(0,10,'Pagina '.$this->PageNo().'/{nb}',0,0,'C');
    }

    // Tabla simple
    function BasicTable($header, $data) {
        // Cabecera
        foreach($header as $col)
            $this->Cell(48,7,$col,1);
        $this->Ln();
        // Datos
        foreach($data as $row) {
            foreach($row as $col)
                $this->Cell(48,6,$col,1);
            $this->Ln();
        }
    }
}

// Creación del objeto de la clase heredada
$pdf = new PDF();
$pdf->AliasNbPages();
$pdf->AddPage();
$pdf->SetFont('Arial','',12);

// Columnas
$header = array('Lote', 'Fecha Produccion', 'Total Disponible (kg)', 'Precio Total');

// Obtener datos
$producto = new Producto();
$lotes = $producto->obtenerLotesProductoTerminado();

// Formatear datos
$data = [];
foreach ($lotes as $lote) {
    $data[] = [
        $lote['lote'],
        $lote['fecha_produccion'],
        $lote['total_disponible'],
        $lote['precio_total']
    ];
}

// Tabla
$pdf->BasicTable($header, $data);
$pdf->Output();
?>