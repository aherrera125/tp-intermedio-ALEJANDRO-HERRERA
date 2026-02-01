DUENIOS
Listar todos
curl -X GET http://localhost:3000/api/duenios

Obtener por id
curl -X GET http://localhost:3000/api/duenios/1

Crear un dueño
curl -X POST http://localhost:3000/api/duenios \
 -H "Content-Type: application/json" \
 -d '{"nombre":"Juan","apellido":"Perez","telefono":123456789,"direccion":"Calle Falsa 123"}'

Actualizar un dueño
curl -X PUT http://localhost:3000/api/duenios/8 \
 -H "Content-Type: application/json" \
 -d '{"nombre":"Juan","apellido":"Gomez","telefono":987654321,"direccion":"Av. Siempreviva 742"}'

Eliminar un dueño
curl -X DELETE http://localhost:3000/api/duenios/8

MASCOTAS
Listar todas
curl -sS http://localhost:3000/api/mascotas

Obtener por id
curl -sS http://localhost:3000/api/mascotas/1

Crear una mascota
curl -sS -X POST http://localhost:3000/api/mascotas \
 -H "Content-Type: application/json" \
 -d '{"nombre":"Fido","especie":"Perro","fecha_nacimiento":"2020-05-01","id_duenio":"2"}'

Actualizar una mascota
curl -sS -X PUT http://localhost:3000/api/mascotas/5 \
 -H "Content-Type: application/json" \
 -d '{"nombre":"Fido Actualizado","especie":"Perro","fecha_nacimiento":"2020-05-01","id_duenio":"2"}'

Eliminar una mascota
curl -sS -X DELETE http://localhost:3000/api/mascotas/5
