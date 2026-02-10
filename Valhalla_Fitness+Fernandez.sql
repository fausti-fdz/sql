-- PROYECTO: Valhalla Fitness
-- DESCRIPCIÓN: Creación de estructura de base de datos para red de gimnasios.
-- AUTOR: Faustina Fernandez
-- FECHA: 10-02-2026

-- 1. Creación de la Base de Datos
CREATE DATABASE IF NOT EXISTS valhalla_fitness;
USE valhalla_fitness;

-- 2. Tabla: SEDES
-- Almacena las sucursales físicas en Bariloche.
CREATE TABLE SEDES (
    id_sede INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_sede VARCHAR(50) NOT NULL,
    dir_sede VARCHAR(100) NOT NULL
);

-- 3. Tabla: SOCIOS
-- Información personal de los clientes. 
CREATE TABLE SOCIOS (
    id_socio INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    dni_socio INT NOT NULL UNIQUE,
    nombre_socio VARCHAR(50) NOT NULL,
    apellido_socio VARCHAR(50) NOT NULL,
    email_socio VARCHAR(100),
    fecha_alta DATE NOT NULL
);

-- 4. Tabla: PLANES
-- Define los tipos de membresías y sus costos.
CREATE TABLE PLANES (
    id_plan INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_plan VARCHAR(50) NOT NULL,
    duracion_mes INT NOT NULL,
    precio_plan DECIMAL(10, 2) NOT NULL
);

-- 5. Tabla: CONTRATOS
-- Relaciona socios con planes y controla la vigencia del servicio.
CREATE TABLE CONTRATOS (
    id_contrato INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_socio INT NOT NULL,
    id_plan INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    FOREIGN KEY (id_socio) REFERENCES SOCIOS(id_socio),
    FOREIGN KEY (id_plan) REFERENCES PLANES(id_plan)
);

-- 6. Tabla: ACTIVIDADES
-- Catálogo de actividades (Yoga, Musculación, etc).
CREATE TABLE ACTIVIDADES (
    id_actividad INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_actividad VARCHAR(50) NOT NULL
);

-- 7. Tabla: CRONOGRAMA_CLASES
-- Define cuándo y dónde se dicta cada actividad.
CREATE TABLE CRONOGRAMA_CLASES (
    id_clase INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_actividad INT NOT NULL,
    id_sede INT NOT NULL,
    dia_sem VARCHAR(15) NOT NULL,
    hora_inicio TIME NOT NULL,
    cupo_max INT NOT NULL,
    FOREIGN KEY (id_actividad) REFERENCES ACTIVIDADES(id_actividad),
    FOREIGN KEY (id_sede) REFERENCES SEDES(id_sede)
);

-- 8. Tabla: ASISTENCIAS
-- Registro de concurrencia diaria para análisis de rentabilidad.
CREATE TABLE ASISTENCIAS (
    id_asistencia INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_socio INT NOT NULL,
    id_clase INT NOT NULL,
    fecha_clase DATE NOT NULL,
    FOREIGN KEY (id_socio) REFERENCES SOCIOS(id_socio),
    FOREIGN KEY (id_clase) REFERENCES CRONOGRAMA_CLASES(id_clase)
);