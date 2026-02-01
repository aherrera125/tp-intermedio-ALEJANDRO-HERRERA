import express, { Request, Response } from "express";
import path from "path";
import "dotenv/config";
import dueniosRoutes from "./routes/duenios.routes";
import mascotasRoutes from "./routes/mascotas.routes";
import veterinariosRoutes from "./routes/veterinarios.routes";
import historialClinicoRoutes from "./routes/historialClinico.routes";

const app = express(); // Creamos la aplicación Express
const PORT = process.env.PORT || 3000; // Definimos el puerto del servidor

app.use(express.json()); // Middleware para interpretar JSON

app.use(express.static(path.join(__dirname, "..", "public"))); // Middleware para servir archivos estáticos desde la carpeta "public"

app.use("/api/duenios", dueniosRoutes);
app.use("/api/mascotas", mascotasRoutes);
app.use("/api/veterinarios", veterinariosRoutes);
app.use("/api/historialClinico", historialClinicoRoutes);

// Iniciar el servidor HTTP
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT} 🚀`);
});
