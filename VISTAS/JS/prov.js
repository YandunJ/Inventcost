$(document).ready(function () {
    var table = $('#proveedoresTable').DataTable({
        "language": {
            "url": "//cdn.datatables.net/plug-ins/1.11.5/i18n/Spanish.json" 
            
        }
    });


    $("#proveedorForm").on("submit", function (event) {
        event.preventDefault();
        if (camposCompletos()) {
            guardarProveedor();
        } else {
            alert("Completa todos los campos antes de guardar.");
        }
    });

    $("#btnActualizar").hide();
    $("#btnEliminar").hide();

    function camposCompletos() {
        return ($("#nombre_empresa").val() && $("#representante").val() && $("#direccion").val() && $("#correo").val() && $("#telefono").val());
    }

    function guardarProveedor() {
        var formData = {
            nombre_empresa: $("#nombre_empresa").val(),
            representante: $("#representante").val(),
            direccion: $("#direccion").val(),
            correo: $("#correo").val(),
            telefono: $("#telefono").val(),
            action: "guardarDatosProveedor"
        };

        $.ajax({
            url: "../AJAX/ctrProveedores.php",
            type: "POST",
            data: formData,
            success: function (response) {
                var res = JSON.parse(response);
                if (res.status === "success") {
                    alert("Proveedor registrado exitosamente.");
                    $("#proveedorForm")[0].reset();
                    cargarProveedores();
                } else {
                    alert("Error al registrar el proveedor: " + res.message);
                }
            },
            error: function (xhr, status, error) {
                alert("Ocurrió un error: " + error);
            }
        });
    }

    function cargarProveedores() {
        $.ajax({
            url: "../AJAX/ctrProveedores.php",
            type: "POST",
            data: { action: "obtenerProveedores" },
            success: function (response) {
                var res = JSON.parse(response);
                if (res.status === "success") {
                    llenarTabla(res.data);
                } else {
                    alert("Error al obtener los proveedores: " + res.message);
                }
            },
            error: function (xhr, status, error) {
                alert("Ocurrió un error: " + error);
            }
        });
    }
    function llenarTabla(proveedores) {
        var table = $('#proveedoresTable').DataTable();
        table.clear();
        proveedores.forEach(function (proveedor) {
            table.row.add([
                proveedor.proveedor_id,
                proveedor.nombre_empresa,
                proveedor.representante,
                proveedor.direccion,
                proveedor.correo,
                proveedor.telefono,
                proveedor.fecha_registro,
                '<button class="btn btn-warning btn-edit" data-id="' + proveedor.proveedor_id + '">Editar</button>' +
                '<button class="btn btn-danger btn-delete" data-id="' + proveedor.proveedor_id + '">Eliminar</button>'
            ]).draw();
        });
    }
    

    $('#proveedoresTable').on('click', '.btn-edit', function () {
        var proveedor_id = $(this).data('id');
        obtenerProveedor(proveedor_id);
    });

    $('#proveedoresTable').on('click', '.btn-delete', function () {
        var proveedor_id = $(this).data('id');
        if (confirm("¿Estás seguro de eliminar este proveedor?")) {
            eliminarProveedor(proveedor_id);
        }
    });

    function obtenerProveedor(proveedor_id) {
        $.ajax({
            url: "../AJAX/ctrProveedores.php",
            type: "POST",
            data: { proveedor_id: proveedor_id, action: "obtenerProveedor" },
            success: function (response) {
                var res = JSON.parse(response);
                if (res.status === "success") {
                    $("#proveedor_id").val(res.data.proveedor_id);
                    $("#nombre_empresa").val(res.data.nombre_empresa);
                    $("#representante").val(res.data.representante);
                    $("#direccion").val(res.data.direccion);
                    $("#correo").val(res.data.correo);
                    $("#telefono").val(res.data.telefono);
                    $("#btnGuardar").hide();
                    $("#btnActualizar").show();
                    $("#btnEliminar").show();
                } else {
                    alert("Error al obtener el proveedor: " + res.message);
                }
            },
            error: function (xhr, status, error) {
                alert("Ocurrió un error: " + error);
            }
        });
    }

    $("#btnActualizar").on("click", function () {
        actualizarProveedor();
    });

    function actualizarProveedor() {
        var formData = {
            proveedor_id: $("#proveedor_id").val(),
            nombre_empresa: $("#nombre_empresa").val(),
            representante: $("#representante").val(),
            direccion: $("#direccion").val(),
            correo: $("#correo").val(),
            telefono: $("#telefono").val(),
            action: "actualizarDatosProveedor"
        };

        $.ajax({
            url: "../AJAX/ctrProveedores.php",
            type: "POST",
            data: formData,
            success: function (response) {
                var res = JSON.parse(response);
                if (res.status === "success") {
                    alert("Proveedor actualizado exitosamente.");
                    $("#proveedorForm")[0].reset();
                    cargarProveedores();
                    $("#btnGuardar").show();
                    $("#btnActualizar").hide();
                    $("#btnEliminar").hide();
                } else {
                    alert("Error al actualizar el proveedor: " + res.message);
                }
            },
            error: function (xhr, status, error) {
                alert("Ocurrió un error: " + error);
            }
        });
    }

    function eliminarProveedor(proveedor_id) {
        $.ajax({
            url: "../AJAX/ctrProveedores.php",
            type: "POST",
            data: { proveedor_id: proveedor_id, action: "eliminarDatosProveedor" },
            success: function (response) {
                var res = JSON.parse(response);
                if (res.status === "success") {
                    alert("Proveedor eliminado exitosamente.");
                    cargarProveedores();
                } else {
                    alert("Error al eliminar el proveedor: " + res.message);
                }
            },
            error: function (xhr, status, error) {
                alert("Ocurrió un error: " + error);
            }
        });
    }

    cargarProveedores();
});
