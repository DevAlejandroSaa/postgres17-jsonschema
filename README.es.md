![Banner](banner.png)

# 🐘 PostgreSQL 17 + JSON Schema

Imagen Docker basada en PostgreSQL 17 que incorpora la extensión **pg_jsonschema** preinstalada y lista para usar.

---

## 🔗 Enlaces

<img src="https://www.svgrepo.com/show/448221/docker.svg" width="24" height="24" style="vertical-align: middle;" /> **Docker Hub:** https://hub.docker.com/r/devalejandrosaa/postgres17-jsonschema  
<img src="https://www.svgrepo.com/show/305241/github.svg" width="24" height="24" style="vertical-align: middle;" /> **GitHub:** https://github.com/devalejandrosaa/postgres17-jsonschema

---

## 🎯 Objetivo

Facilitar el uso de validaciones JSON Schema directamente desde PostgreSQL sin necesidad de compilar extensiones manualmente ni preparar entornos de desarrollo Rust.

La imagen incluye todos los componentes necesarios para crear y utilizar la extensión:

```sql
CREATE EXTENSION pg_jsonschema;
```

---

## 📦 Versiones incluidas

| Componente    | Versión |
| ------------- | ------- |
| PostgreSQL    | 17.10   |
| pg_jsonschema | 0.3.4   |
| Rust          | 1.91.1  |
| cargo-pgrx    | 0.16.1  |

---

## 🚀 Uso rápido

### Ejecutar PostgreSQL

```bash
docker run -d \
  --name postgres17-jsonschema \
  -e POSTGRES_PASSWORD=password \
  -p 5432:5432 \
  devalejandrosaa/postgres17-jsonschema:17.10-0.3.4
```

### Habilitar la extensión

```sql
CREATE EXTENSION pg_jsonschema;
```

### Verificar instalación

```sql
SELECT extname
FROM pg_extension
WHERE extname = 'pg_jsonschema';
```

---

## 🏗️ Proceso de construcción

La imagen se construye mediante un proceso multi-stage para reducir el tamaño final y evitar incluir herramientas innecesarias en producción.

### Etapa de compilación

Se utilizan:

* Rust 1.91.1
* cargo-pgrx 0.16.1
* PostgreSQL 17 Development Headers
* LLVM
* Clang

Durante la compilación:

1. Se instala `cargo-pgrx`.
2. Se inicializa únicamente PostgreSQL 17.
3. Se descarga el código fuente de `pg_jsonschema`.
4. Se compila la extensión.
5. Se eliminan símbolos de depuración mediante `strip`.

### Etapa final

La imagen final utiliza:

```text
postgres:17
```

Únicamente se copian los archivos necesarios:

```text
/usr/lib/postgresql/17/lib/pg_jsonschema.so
/usr/share/postgresql/17/extension/pg_jsonschema.control
/usr/share/postgresql/17/extension/pg_jsonschema--*.sql
```

Esto permite reducir considerablemente el tamaño de la imagen final.

---

## 📂 Archivos instalados

```text
/usr/lib/postgresql/17/lib/pg_jsonschema.so
/usr/share/postgresql/17/extension/pg_jsonschema.control
/usr/share/postgresql/17/extension/pg_jsonschema--0.3.4.sql
```

---

## 📈 Versionado

El proyecto utiliza el siguiente esquema:

```text
<postgresql-version>-<pg_jsonschema-version>
```

Ejemplos:

```text
17.10-0.3.4
17.10-0.3.5
17.11-0.3.5
```

---

## 🏷️ Releases

Cada versión publicada genera:

* Un Tag Git.
* Un Release en GitHub.
* Un Tag correspondiente en Docker Hub.

Ejemplo:

```text
GitHub Release:
v17.10-0.3.4

Docker Image:
17.10-0.3.4
```

---

## 📋 Hoja de ruta

### PostgreSQL 17

* Mantener compatibilidad con PostgreSQL 17.
* Incorporar nuevas versiones de pg_jsonschema.
* Publicar nuevas imágenes versionadas.
* Mantener tags históricos para reproducibilidad.

---

## 🤝 Contribuciones

Las contribuciones, reportes de errores y mejoras son bienvenidas mediante Issues y Pull Requests.

---

## 📜 Licencia

MIT License.