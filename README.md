# Docker Laravel Multi-Project Setup

Este entorno Docker está pensado para trabajar con **Laravel 12+** y permitir tener **múltiples proyectos Laravel en paralelo** dentro de una misma instancia, apuntando automáticamente a la carpeta `public/`.

> Ideal para desarrollo local, compatible con MySQL, Node.js, Vite, Composer, Apache, etc.

---

## 📁 Estructura del proyecto

```
docker-compose-laravel/
├── .docker/
│   └── apache/
│       └── 000-default.conf
├── www/
│   ├── miproyecto/
│   ├── miproyecto2/
│   └── ...
├── docker-compose.yml
├── Dockerfile
└── .gitignore
```

---

## ⚖️ Requisitos previos

- Docker Desktop
- Git

Opcional para trabajar:
- VS Code + Docker extension
- HeidiSQL / MySQL Workbench para ver la base de datos

---

## 🚀 Pasos para usar este entorno

### 1. Clonar este repositorio

```bash
cd C:\projects
git clone https://github.com/tuusuario/docker-compose-laravel.git
cd docker-compose-laravel
```

### 2. Levantar el entorno Docker

```bash
docker-compose up -d --build
```

Esto levantará:
- Apache + PHP 8.2 + Composer + Node.js
- MySQL 8 en el puerto **3307** con usuario y clave: `laravel`

### 3. Crear un nuevo proyecto Laravel

Entrar al contenedor:

```bash
docker exec -it laravel-app bash
```

Instalar Laravel dentro de la carpeta `www` (por ejemplo `miproyecto`):

```bash
cd /var/www/html
composer create-project laravel/laravel miproyecto
```

### 4. Configurar la base de datos en `.env`

Editar el archivo `.env` dentro de tu proyecto Laravel:

```env
DB_CONNECTION=mysql
DB_HOST=laravel-db
DB_PORT=3306
DB_DATABASE=aizagest_chile
DB_USERNAME=laravel
DB_PASSWORD=laravel
```

### 5. Dar permisos

```bash
cd /var/www/html/miproyecto
chmod -R 775 storage bootstrap/cache
chown -R www-data:www-data storage bootstrap/cache
```

### 6. Migrar la base de datos

```bash
php artisan migrate
```

### 7. Acceder en el navegador

Ir a:
```
http://localhost:8080/miproyecto/public
```

---

## 🔐 Acceder a MySQL desde HeidiSQL / Workbench

| Campo       | Valor       |
|-------------|-------------|
| Host        | `localhost` |
| Puerto      | `3307`      |
| Usuario     | `laravel`   |
| Contraseña  | `laravel`   |

---

## 📂 Estructura pensada para varios Laravel

Podés tener muchos proyectos dentro de la carpeta `www/`:

```
www/
├── miproyecto/
├── miproyecto2/
└── laravel-prueba/
```

Y acceder a cada uno vía:
```
http://localhost:8080/miproyecto/public
http://localhost:8080/miproyecto2/public
```

---

## 📍 Notas

- No elimines el volumen de MySQL si no querés perder los datos: **no usar `docker-compose down -v`**
- Este entorno está pensado para desarrollo local. No usar en producción sin modificar configuraciones de seguridad.
- Se acepta feedback y mejoras en pull requests :)

---

## 🚤 Crédito

Este entorno fue creado con mucho amor por [Cristian], que sufrió todo para que tú no tengas que hacerlo. ❤️
