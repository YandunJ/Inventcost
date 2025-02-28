SELECT * FROM fpulpas.roles;

ALTER TABLE roles ADD COLUMN rol_descripcion VARCHAR(255);

UPDATE roles SET rol_descripcion = 'Tiene acceso completo al sistema' WHERE rol_id = 1;
UPDATE roles SET rol_descripcion = 'Gestiona la materia prima en el inventario' WHERE rol_id = 2;
UPDATE roles SET rol_descripcion = 'Encargado de la producción de productos' WHERE rol_id = 3;