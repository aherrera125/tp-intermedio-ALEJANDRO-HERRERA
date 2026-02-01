Listar todos
curl -X GET http://localhost:3000/api/duenios

Obtener por id
curl -X GET http://localhost:3000/api/duenios/1

Crear un dueño
curl -X POST http://localhost:3000/api/duenios \
 -H "Content-Type: application/json" \
 -d '{"nombre":"Juan","apellido":"Perez","telefono":123456789,"direccion":"Calle Falsa 123"}'

Actualizar un dueño
curl -X PUT http://localhost:3000/api/duenios/7 \
 -H "Content-Type: application/json" \
 -d '{"nombre":"Juan","apellido":"Gomez","telefono":987654321,"direccion":"Av. Siempreviva 742"}'

Eliminar un dueño
curl -X DELETE http://localhost:3000/api/duenios/7
