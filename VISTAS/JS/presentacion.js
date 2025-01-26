$(document).ready(function () {
    // Cargar categorías desde la base de datos
    function cargarCategorias() {
        $.ajax({
            url: '../AJAX/ctrInvCatalogo.php',
            type: 'POST',
            data: { action: 'getCategorias' },
            success: function (response) {
                const result = JSON.parse(response);
                if (result.status === 'success' && Array.isArray(result.data)) {
                    let options = "<option value=''>Seleccione una categoría</option>";
                    result.data.forEach(function (categoria) {
                        if (categoria.ctg_id == 2 || categoria.ctg_id == 3) { // Solo cargar Insumos y Producto Terminado
                            options += `<option value="${categoria.ctg_id}">${categoria.ctg_nombre}</option>`;
                        }
                    });
                    $('#categoria').html(options);
                    $('#filtroCategoria').html(options);
                } else {
                    console.error("Error al cargar categorías: ", result);
                }
            },
            error: function (xhr, status, error) {
                console.error("Error: ", error);
                console.error("Response: ", xhr.responseText);
            }
        });
    }

    // Cargar presentaciones desde la base de datos
    function cargarPresentaciones(filtroCategoria = '3') {
        $.ajax({
            url: '../AJAX/ctrPresent.php',
            type: 'POST',
            data: { action: 'obtenerTodasPresentaciones' },
            success: function (response) {
                const presentaciones = JSON.parse(response);
                let filas = '';
                presentaciones.forEach(presentacion => {
                    if (filtroCategoria == '' || (filtroCategoria == '2' && presentacion.ctg_id != '3') || (filtroCategoria == '3' && presentacion.ctg_id == '3')) {
                        filas += `
                            <tr>
                                <td>${presentacion.prs_nombre}</td>`;
                        if (filtroCategoria == '2') {
                            filas += `<td>${presentacion.prs_abreviacion}</td>`;
                        }
                        if (filtroCategoria == '3') {
                            filas += `
                                <td>${presentacion.equivalencia}</td>
                                <td>${presentacion.prs_estado == 'vigente' ? 'Vigente' : 'Descontinuado'}</td>`;
                        }
                        filas += `
                                <td>
                                    <button type="button" class="btn btn-warning btn-sm editar-presentacion" data-id="${presentacion.prs_id}">Editar</button>
                                </td>
                            </tr>`;
                    }
                });
                $('#presentacionTable tbody').html(filas);

                // Mostrar u ocultar columnas según la categoría seleccionada
                if (filtroCategoria == '2') {
                    $('.abreviacion-column').show();
                    $('.equivalencia-column').hide();
                    $('.estado-column').hide();
                } else {
                    $('.abreviacion-column').hide();
                    $('.equivalencia-column').show();
                    $('.estado-column').show();
                }
                $('.categoria-column').hide(); // Ocultar siempre la columna de categoría
            },
            error: function (xhr, status, error) {
                console.error("Error: ", error);
                console.error("Response: ", xhr.responseText);
            }
        });
    }

    // Mostrar u ocultar los campos de equivalencia y estado según la categoría seleccionada
    $('#categoria').on('change', function () {
        if ($(this).val() == '3') { // Producto Terminado
            $('#abreviacion').removeAttr('required');
            $('#abreviacionContainer').hide();
            $('#equivalenciaContainer').show();
            $('#estadoContainer').show();
        } else {
            $('#abreviacion').attr('required', 'required');
            $('#abreviacionContainer').show();
            $('#equivalenciaContainer').hide();
            $('#estadoContainer').hide();
        }
    });

    // Filtrar presentaciones por categoría
    $('#filtroCategoria').on('change', function () {
        const filtroCategoria = $(this).val();
        cargarPresentaciones(filtroCategoria);
    });

    // Agregar o actualizar presentación
    $('#presentacionForm').on('submit', function (e) {
        e.preventDefault();
        const prs_id = $('#id_presentacion').val();
        const prs_nombre = $('#nombre').val();
        const prs_abreviacion = $('#abreviacion').val();
        const prs_estado = $('#estado').is(':checked') ? 'vigente' : 'descontinuado';
        const ctg_id = $('#categoria').val();
        const equivalencia = parseFloat($('#equivalencia').val()) || 0;

        const action = prs_id == 0 ? 'registrarPresentacion' : 'actualizarPresentacion';

        $.ajax({
            url: '../AJAX/ctrPresent.php',
            type: 'POST',
            data: {
                action: action,
                prs_id: prs_id,
                prs_nombre: prs_nombre,
                prs_abreviacion: ctg_id == '3' ? '' : prs_abreviacion,
                prs_estado: prs_estado,
                ctg_id: ctg_id,
                equivalencia: equivalencia
            },
            success: function (response) {
                try {
                    const result = JSON.parse(response);
                    if (result.status === 'success') {
                        Swal.fire({
                            icon: 'success',
                            title: 'Éxito',
                            text: result.message || 'Presentación guardada correctamente',
                        });
                        $('#modalFormulario').modal('hide');
                        cargarPresentaciones();
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: result.message || 'Error desconocido',
                        });
                    }
                } catch (e) {
                    console.error("Respuesta inválida del servidor: ", response);
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Error al procesar la respuesta del servidor.',
                    });
                }
            },
            error: function (xhr, status, error) {
                console.error("Error: ", error);
                console.error("Response: ", xhr.responseText);
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Error en el servidor. Verifique la consola para más detalles.',
                });
            }
        });
    });

    // Editar presentación
    $('#presentacionTable').on('click', '.editar-presentacion', function () {
        const prs_id = $(this).data('id');
        $.ajax({
            url: '../AJAX/ctrPresent.php',
            type: 'POST',
            data: { action: 'obtenerPresentacionPorId', prs_id: prs_id },
            success: function (response) {
                const presentacion = JSON.parse(response);
                $('#id_presentacion').val(presentacion.prs_id);
                $('#nombre').val(presentacion.prs_nombre);
                $('#abreviacion').val(presentacion.prs_abreviacion);
                $('#estado').prop('checked', presentacion.prs_estado === 'vigente');
                $('#categoria').val(presentacion.ctg_id);
                $('#equivalencia').val(presentacion.equivalencia);
                if (presentacion.ctg_id == '3') {
                    $('#abreviacion').removeAttr('required');
                    $('#abreviacionContainer').hide();
                    $('#equivalenciaContainer').show();
                    $('#estadoContainer').show();
                } else {
                    $('#abreviacion').attr('required', 'required');
                    $('#abreviacionContainer').show();
                    $('#equivalenciaContainer').hide();
                    $('#estadoContainer').hide();
                }
                $('#modalFormulario').modal('show');
            },
            error: function (xhr, status, error) {
                console.error("Error: ", error);
                console.error("Response: ", xhr.responseText);
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Error al obtener los datos de la presentación. Verifique la consola para más detalles.',
                });
            }
        });
    });

    // Cambiar el texto del estado según el checkbox
    const estadoCheckbox = document.getElementById("estado");
    const estadoText = document.getElementById("estado-text");

    estadoCheckbox.addEventListener("change", () => {
        if (estadoCheckbox.checked) {
            estadoText.textContent = "Vigente";
            estadoText.style.color = "#4CAF50";
        } else {
            estadoText.textContent = "Descontinuado";
            estadoText.style.color = "#FF0000";
        }
    });

    // Cargar categorías y presentaciones al cargar la página
    cargarCategorias();
    cargarPresentaciones();
});