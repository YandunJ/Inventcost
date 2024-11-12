SELECT * FROM fpulpas.categorias;

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_registro DATE NOT NULL
);

INSERT INTO categorias (nombre_categoria, descripcion, fecha_registro)
VALUES
('Materia Prima', 'Frutas para almacenamiento y uso en producción', '2024-10-05'),
('Insumos', 'Materiales utilizados en la producción', '2024-10-05'),
('Productos Terminado', 'Paquetes de Pulpa Procesada', '2024-10-05');
