$(document).ready(function() {
    // Función para actualizar la cantidad
    function updateQuantity(amount, inputId) {
        const inputField = document.getElementById(inputId);
        if (!inputField) return;
        const minValue = parseFloat(inputField.getAttribute('min')) || 0;
        const stepValue = parseFloat(inputField.getAttribute('step')) || 1;
        const currentValue = parseFloat(inputField.value) || minValue;

        const newValue = Math.max(currentValue + (amount * stepValue), minValue);
        inputField.value = newValue.toFixed(2);
    }

    // Eventos para los botones
    $(".btn-minus").on("click", function() {
        updateQuantity(-1, "cantidad_ingresada");
    });

    $(".btn-plus").on("click", function() {
        updateQuantity(1, "cantidad_ingresada");
    });
});
