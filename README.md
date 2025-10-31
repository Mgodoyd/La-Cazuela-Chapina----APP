# cazuela_chapina_app

Aplicación Flutter para la gestión de ventas, inventario y operaciones en La Cazuela Chapina.

---

## Índice
- [cazuela\_chapina\_app](#cazuela_chapina_app)
  - [Índice](#índice)
  - [Descripción](#descripción)
  - [Requisitos](#requisitos)
  - [Instalación](#instalación)
  - [Ejecución](#ejecución)
  - [Estructura del proyecto](#estructura-del-proyecto)
  - [Uso general](#uso-general)
    - [Funcionalidades principales:](#funcionalidades-principales)
  - [Anexos](#anexos)

---

## Descripción
Este proyecto es una solución móvil desarrollada en Flutter para optimizar el control de ventas, gestión de proveedores, productos, mesas y procesos logísticos para restaurantes y ventas por delivery.

## Requisitos
- Flutter
- Dart 
- Editor recomendado: VSCode o Android Studio
- Dispositivo emulador o físico con Android/iOS/Web

## Instalación
1. Asegúrate de tener Flutter instalado:<br/>
   [Instalar Flutter](https://docs.flutter.dev/get-started/install)
2. Clona el repositorio en tu equipo.
3. Instala dependencias:
   ```bash
   flutter pub get
   ```
4. Configura la plataforma deseada:
   ```bash
   flutter config --enable-web
   flutter devices
   ```

## Ejecución
Ejecuta el siguiente comando dependiendo la plataforma:
```bash
flutter run -d <dispositivo>
```

## Estructura del proyecto
- `lib/src/`: Lógica y presentación principal de la app.
  - `core/`: Servicios, modelos y utilidades compartidas
  - `features/`: Pantallas y módulos independientes (ventas, proveedores, inventario, etc.)
  - `main.dart`: Entry point de la aplicación
- `anexos/`: Imágenes de flujos, ejemplos y pruebas para referencia rápida

## Uso general
La aplicación permite el control de ventas tanto online como offline, administración de inventario, registro de proveedores, control de mesas y soporte para actividades propias del rubro gastronómico, incluyendo funcionalidades como colas offline, ventas personalizadas, sincronización y reportes detallados.

### Funcionalidades principales:
- Venta de productos estándar y personalizados
- Gestión de operaciones con conexión intermitente (offline/online)
- Inventario y órdenes
- Listados y edición de proveedores
- Mapa de mesas
- Informes y reportes
- Sincronización de datos en background

## Anexos

A continuación se presentan algunas capturas y ejemplos de la operativa del sistema:

<!-- Galería de imágenes -->

- ![añadir inventario](anexos/añadir inventario.jpg)
- ![añadir producto](anexos/añadir producto.jpg)
- ![añadir stock al inventario](anexos/añadir stock al inventario.jpg)
- ![catálogo productos](anexos/catálogo productos.jpg)
- ![chat ia](anexos/chat ia.jpg)
- ![chat ia 2](anexos/chat ia 2.jpg)
- ![cola de ventas offline](anexos/cola de ventas offline.jpg)
- ![cola offline vacia](anexos/cola offline vacia.jpg)
- ![cronometraje de lotes](anexos/cronometraje de lotes.jpg)
- ![dash](anexos/dash.jpg)
- ![editar ordenes](anexos/editar ordenes.jpg)
- ![editar proveedore](anexos/editar proveedore.jpg)
- ![editar sucursales](anexos/editar sucursales.jpg)
- ![eliminar inventario](anexos/eliminar inventario.jpg)
- ![Filtro fecha](anexos/Filtro fecha.jpg)
- ![inventario](anexos/inventario.jpg)
- ![limpiar cola](anexos/limpiar cola.jpg)
- ![login](anexos/login.jpg)
- ![logistica envios](anexos/logistica envios.jpg)
- ![mapa de mesas](anexos/mapa de mesas.jpg)
- ![offline bebida](anexos/offline bebida.jpg)
- ![offline combo](anexos/offline combo.jpg)
- ![ordenes](anexos/ordenes.jpg)
- ![proveedores](anexos/proveedores.jpg)
- ![RAG IA](anexos/RAG IA.jpg)
- ![Reportes](anexos/Reportes.jpg)
- ![sucursales](anexos/sucursales.jpg)
- ![venta offline](anexos/venta offline.jpg)
- ![venta online bebida personalizada](anexos/venta online bebida personalizada.jpg)
- ![venta online tamal personalizado](anexos/venta online tamal personalizado.jpg)
- ![venta online vacio](anexos/venta online vacio.jpg)
- ![venta online](anexos/venta online.jpg)
- ![ventas online producto existente](anexos/ventas online producto existente.jpg)
