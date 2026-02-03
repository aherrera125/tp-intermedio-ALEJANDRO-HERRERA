-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Servidor: mysql:3306
-- Tiempo de generación: 03-02-2026 a las 02:51:57
-- Versión del servidor: 8.0.44
-- Versión de PHP: 8.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Base de datos: `veterinaria_patitas_felices`
--

CREATE DATABASE veterinaria_patitas_felices;
USE veterinaria_patitas_felices;

-- --------------------------------------------------------

-- Estructura de la tabla `duenos`
CREATE TABLE duenos(
	id int PRIMARY KEY AUTO_INCREMENT,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
    telefono varchar(20) not null,
    direccion varchar(100)
);

-- Estructura de la tabla `mascotas`
CREATE TABLE mascotas(
	id int PRIMARY KEY AUTO_INCREMENT,
    id_dueno int not null,
	nombre varchar(50) not null,
	especie varchar(30) not null,
    fecha_nacimiento date,
    FOREIGN KEY (id_dueno) REFERENCES duenos(id)
);

-- Estructura de la tabla `veterinarios`
CREATE TABLE veterinarios(
	id int PRIMARY KEY AUTO_INCREMENT,    
	nombre varchar(50) not null,
	apellido varchar(50) not null,
    matricula varchar(20) not null UNIQUE,
    especialidad varchar(50) not null
);

-- Estructura de la tabla `historial_clinico` 
CREATE TABLE historial_clinico(
	id int PRIMARY KEY AUTO_INCREMENT,    
	id_mascota int not null,
    id_veterinario int not null,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP not null,
    descripcion varchar(250) not null,
    FOREIGN KEY (id_mascota) REFERENCES mascotas(id) ON DELETE CASCADE,
    FOREIGN KEY (id_veterinario) REFERENCES veterinarios(id) ON DELETE CASCADE
);

-- Volcado de datos para la tabla `duenos`
insert into duenos(nombre,apellido,telefono,direccion)
VALUES ('Juan Carlos','Medina','3815153426','Av. Roca 1258'),
('Miguel','Flores','3814852456','Silvano Bores 542'),
('Marcela Luz','Quintero','3813789123','Calle de Barcelona 1041');

-- Volcado de datos para la tabla `mascotas`
insert into mascotas(id_dueno, nombre, especie, fecha_nacimiento)
VALUES (1,'Rocco Rodolfo','perro','2020-05-14'),
(2,'Alvin Martin','Conejo','2023-08-03'),
(3,'Mike Morel','gato','2018-10-25');

-- Volcado de datos para la tabla `veterinarios`
insert into veterinarios(nombre, apellido, matricula, especialidad)
VALUES ('Lucia','Padilla','vt25468','Cirugía Veterinaria'),
('Ignacio','Corbalan','vt852456','Oncología'),
('Paula','Albarracin','vt789651','Clínica general');

-- Volcado de datos para la tabla `historial_clinico`
insert into historial_clinico(id_mascota, id_veterinario, fecha_registro, descripcion)
VALUES (1, 2, '2024-10-12', 'Infeccion urinaria'),
(3, 1, '2025-08-01', 'Traumatismo de craneo'),
(2, 3, '2023-12-15','Hemorragia intestinal');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'admin'),
(2, 'user');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `created_at`, `updated_at`) VALUES
(1, 'testuser', 'test@example.com', '$2b$10$sVVMzD8RdA2ziTnzI3c86uzB5p91i3L2J4q3KWqCHh1ZFzpoNZ0dW', '2026-02-02 00:07:04', '2026-02-02 00:07:04');

--
-- Disparadores `users`
--
DELIMITER $$
CREATE TRIGGER `assign_user_role` AFTER INSERT ON `users` FOR EACH ROW BEGIN
  DECLARE userRoleId INT;

  -- Buscar ID del rol 'user'
  SELECT id INTO userRoleId FROM roles WHERE name = 'user' LIMIT 1;

  -- Si lo encontró, insertamos
  IF userRoleId IS NOT NULL THEN
    INSERT INTO user_roles (user_id, role_id) VALUES (NEW.id, userRoleId);
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` int NOT NULL,
  `role_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `user_roles`
--

INSERT INTO `user_roles` (`user_id`, `role_id`) VALUES
(1, 2);

-- --------------------------------------------------------

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `duenos`
--
ALTER TABLE `duenos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Filtros para la tabla `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
