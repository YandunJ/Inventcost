SELECT * FROM fpulpas.categorias;

CREATE TABLE categorias (
    ctg_id INT AUTO_INCREMENT PRIMARY KEY,
    ctg_nombre VARCHAR(100) NOT NULL,
    ctg_descripcion TEXT
);


INSERT INTO categorias (ctg_nombre, ctg_descripcion)
VALUES
('Materia Prima', 'Frutas para almacenamiento y uso en producción'),
('Insumos', 'Materiales utilizados en la producción'),
('Productos Terminado', 'Paquetes de Pulpa Procesada');


INSERT INTO categorias (ctg_nombre, ctg_descripcion) VALUES
('Mano de Obra', 'Actividades relacionadas con el trabajo realizado por empleados'),
('Costos Asociados', 'Descripción de costos relacionados con la producción');
