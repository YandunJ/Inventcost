<!-- Modal para ver los detalles de una producción -->
<div class="modal fade modal-entradas" id="verProduccionModal" tabindex="-1" role="dialog" aria-labelledby="verProduccionModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Detalles de Producción</h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="formVerProduccion">
                    <!-- Campos para mostrar los detalles de la producción -->
                    <div class="form-group row">
                        <label for="verFecha" class="col-sm-2 col-form-label">Fecha</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="verFecha" readonly>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="verCantidadProducida" class="col-sm-2 col-form-label">Cantidad Producida</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="verCantidadProducida" readonly>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="verSubtotalMP" class="col-sm-2 col-form-label">Subtotal Materia Prima</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="verSubtotalMP" readonly>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="verSubtotalINS" class="col-sm-2 col-form-label">Subtotal Insumos</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="verSubtotalINS" readonly>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="verSubtotalMO" class="col-sm-2 col-form-label">Subtotal Mano de Obra</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="verSubtotalMO" readonly>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="verSubtotalCI" class="col-sm-2 col-form-label">Subtotal Costos Indirectos</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="verSubtotalCI" readonly>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="verTotal" class="col-sm-2 col-form-label">Total</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="verTotal" readonly>
                        </div>
                    </div>
                    <!-- Aquí puedes agregar más campos según sea necesario -->
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>