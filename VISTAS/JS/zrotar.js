$(document).ready(function(){
    var images = [
        "../FILES/frutas.jpg",
        "../FILES/frutas2.jpg",
        "../FILES/frutas3.jpg",
        "../FILES/fondo3.jpeg"
    ];

    var currentIndex = 0;

    // Establecer la primera imagen de fondo al cargar la página
    $('.image-container').css('background-image', 'url(' + images[currentIndex] + ')');

    function changeImage() {
        currentIndex = (currentIndex + 1) % images.length;
        $('.image-container').css('background-image', 'url(' + images[currentIndex] + ')');
    }

    setInterval(changeImage, 5000); // Cambiar imagen cada 5 segundos
});
