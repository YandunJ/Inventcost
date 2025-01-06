SELECT * FROM fpulpas.presentacion;

CREATE TABLE presentacion (
    prs_id INT AUTO_INCREMENT PRIMARY KEY,
    prs_nombre VARCHAR(50) NOT NULL,
    prs_abreviacion VARCHAR(10) NOT NULL,
    prs_estado ENUM('vigente', 'descontinuado') NOT NULL DEFAULT 'vigente'
);

INSERT INTO presentacion (prs_nombre, prs_abreviacion, prs_estado) VALUES

('Kilogramos', 'kg', 'vigente'),
('Litros', 'lt', 'vigente'),
('Unidades', 'u', 'vigente');
