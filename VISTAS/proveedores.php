<?php include '../CONFIG/validar_sesion.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Proveedores</title>
    <!-- AdminLTE CSS -->
    <link rel="stylesheet" href="../Public/dist/css/adminlte.min.css">
    <link rel="stylesheet" href="../Public/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="../Public/css/ColorPanel.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="../FILES/centrForm.css">
    <link rel="stylesheet" href="../FILES/InvMPModal.css">
    <!-- REVISAR LOS ESTILOS QUE SOLO QUEDE LOS NECESARIOS Y EN CASO DE SER UTIL CENTRALIZAR UN ESTILO PARA DEJAR SOLO UNO PARA TODOS -->
    <link rel="stylesheet" href="../FILES/Table-Compact.css">
</head>
<body class="hold-transition sidebar-mini">
    <div class="wrapper">
        <!-- Navbar -->
        <?php include 'MODULOS/ModuloNavbar.php'; ?>
        <!-- Main Sidebar Container -->
        <?php include 'MODULOS/MDAdminSidebar.php'; ?>

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                <h1 class="text-center">Registrar Proveedores</h1>
                <!-- Botón para abrir el modal -->
<button class="btn btn-primary mb-3" id="addProveedorButton">Agregar Nuevo</button>

<!-- Modal -->
<div class="modal fade" id="proveedorModal" tabindex="-1" aria-labelledby="proveedorModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="proveedorModalLabel">Registrar Proveedor</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="proveedorForm">
          <input type="hidden" id="proveedor_id" name="proveedor_id">
          <div class="form-group">
            <label for="nombre_empresa">Nombre Empresa</label>
            <input type="text" class="form-control" id="nombre_empresa" name="nombre_empresa" placeholder="Empresa XYZ" required maxlength="50">
          </div>
          <div class="form-group">
            <label for="representante">Representante</label>
            <input type="text" class="form-control" id="representante" name="representante" placeholder="Juan Pérez" required maxlength="50">
          </div>
          <div class="form-group">
            <label for="correo">Correo</label>
            <input type="email" class="form-control" id="correo" name="correo" placeholder="empresa@correo.com" required maxlength="40">
          </div>
          <div class="form-group">
            <label for="telefono">Teléfono</label>
            <input type="text" class="form-control" id="telefono" name="telefono" placeholder="Teléfono" required>
          </div>
          <button type="submit" class="btn btn-primary">Guardar</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        </form>
      </div>
    </div>
  </div>
</div>

                
                    <table id="proveedoresTable" class="table table-bordered table-hover table-compact">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre Empresa</th>
                                <th>Representante</th>
                                
                                <th>Correo</th>
                                <th>Teléfono</th>
                                <th>Fecha Registro</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Los datos se llenarán dinámicamente con JavaScript -->
                        </tbody>
                    </table>
                </div>
            </section>
        </div>
          <!-- Main Footer -->
          <footer class="main-footer">
            <div class="float-right d-none d-sm-inline">
                FRAN FRUIT
            </div>
            <strong>Copyright &copy; 2024 <a href="https://www.instagram.com/pulpafranfruit?igsh=MThuYTRrN3Fvcjg1OA==">FranFruit.io</a>.</strong> Derechos Reservados.
        </footer>
    </div>
    
   

         
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="../Public/plugins/jquery/jquery.min.js"></script>
    <script src="../Public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="../Public/dist/js/adminlte.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    <!-- Custom JS -->
    <script src="JS/prov.js"></script> <!-- Ruta al archivo JS -->

    <script src="JS/cerrarsesion.js"></script>

</body>
</html>
