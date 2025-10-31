# cazuela_chapina_app

**Aplicación Flutter de gestión integral para restaurantes y delivery: ventas, inventario y operaciones, diseñada para La Cazuela Chapina.**

---

## Índice

- [cazuela\_chapina\_app](#cazuela_chapina_app)
  - [Índice](#índice)
  - [Descripción General](#descripción-general)
  - [Características Clave](#características-clave)
  - [Arquitectura y Tecnología](#arquitectura-y-tecnología)
  - [Requisitos](#requisitos)
  - [Instalación](#instalación)
  - [Ejecución](#ejecución)
  - [Estructura del Proyecto](#estructura-del-proyecto)
  - [Flujos y Operativa](#flujos-y-operativa)
    - [1. **Venta Online y Offline**](#1-venta-online-y-offline)
    - [2. **Gestión de Inventario y Proveedores**](#2-gestión-de-inventario-y-proveedores)
    - [3. **Mapas de Mesas y Logística**](#3-mapas-de-mesas-y-logística)
    - [4. **Reportes y Métricas**](#4-reportes-y-métricas)
    - [5. **Autenticación y Seguridad**](#5-autenticación-y-seguridad)
    - [6. **Mensajería y Notificaciones**](#6-mensajería-y-notificaciones)
  - [Anexos](#anexos)

---

## Descripción General

`cazuela_chapina_app` es una aplicación Flutter multiplataforma (Android/iOS/Web) desarrollada específicamente para cubrir TODO el ciclo operativo de un restaurante: desde la venta presencial y remota, hasta la gestión de inventario, reportes y logística, adaptándose dinámicamente a condiciones online y offline.

---

## Características Clave

- **Ventas Online y Offline**: Soporte robusto para ventas incluso sin red, con sincronización y almacenamiento en cola (queue) automático.
- **Gestión de Productos Personalizados y Combos**: Flujo para crear productos a demanda, combos y seguimiento unitario.
- **Inventario Inteligente**: Control detallado con registro de movimientos, edición y sincronización sin pérdidas ni duplicados.
- **Proveedores y Órdenes**: Alta, edición y control de proveedores, órdenes de compra y mensajería automática.
- **Control de Mesas/Mesas Mapa Visual**: Representación gráfica del salón, ideal para gestión rápida y visual en restaurante.
- **Notificaciones Push y Mensajería Integral**: Integración con servicios de notificaciones para alertas, informes y eventos.
- **Reportes Detallados**: Acceso desde la app a informes de movimientos, ventas y métricas clave.
- **Autenticación Segura y Multiusuario**: Login JWT, roles, almacenamiento seguro local (Hive, SecureStorage) y soporte multiusuario.
- **UI/UX Moderna y Resiliente**: Interfaz optimizada para usabilidad operativa, excelente legibilidad, respuesta rápida y mensajes orientados al usuario.
- **Integración con Riverpod**: Gestión avanzada del estado y dependencias desacopladas vía Providers y Repositories.

---

## Arquitectura y Tecnología

- **Flutter 3+ (Dart 3+)**: Multiplataforma, eficiente y adaptable.
- **Arquitectura Limpia (Clean Architecture)**:
  - Separación por `core` (servicios/utilidades),
  - `features` (cada módulo funcional encapsulado).
- **Riverpod**: Providers exclusivos para colas offline, providers asincrónicos, notificaciones y más.
- **Gestión de Colas Offline y Sincronización**:
  - Repositorio y servicio en `core/offline` gestionan una cola tipo payload de operaciones pendientes.
  - Al recuperar conectividad, sincroniza con el backend y garantiza idempotencia.
  - Almacenamiento local con Hive para persistencia entre cierres de app.
- **Autenticación y Seguridad**:
  - Tokens JWT extraídos y validados localmente, asociación de ventas a usuario autenticado.
  - SecureStorage para almacenamiento seguro de credenciales.
- **Notificaciones**:
  - Push locales y por API, integradas con Riverpod y disparadas en eventos clave de negocio.
- **Experiencia Offline Completa**:
  - El usuario puede operar, tomar pedidos y sincronizar cuando tenga red, sin miedo a pérdida de datos.
  - Todas las operaciones críticas (ventas, productos, combos, inventario) son resilientes a fallos de red.
- **UI Modular**:
  - Widgets compuestos para cada feature (ventas, inventario, proveedores, etc.).
  - Control de estado reactivo con ConsumerWidget/ConsumerStatefulWidget.

---

## Requisitos

- Flutter 3.x y Dart 3.x
- Dependencias gestionadas por `flutter pub`
- Editor recomendado: VSCode o Android Studio
- Dispositivo físico o emulador (Android/iOS/Web)

---

## Instalación

1. Asegúrate de tener Flutter instalado:<br>
   [Guía oficial Flutter](https://docs.flutter.dev/get-started/install)
2. Clona el repositorio:
   ```bash
   git clone <url_proyecto>
   ```
3. Instala dependencias:
   ```bash
   flutter pub get
   ```
4. Si usas web, habilita:
   ```bash
   flutter config --enable-web
   ```

---

## Ejecución

Para correr la app en cualquier dispositivo compatible:
```bash
flutter run -d <dispositivo>
```

---

## Estructura del Proyecto

```
lib/
├─ src/
│  ├─ core/           # Servicios generales, sincronización offline, proveedores, almacenamiento, utilidades, etc.
│  ├─ features/       # Implementaciones por módulo: ventas, inventario, proveedores, logística, reportes, mesas.
│  ├─ main.dart       # Punto de entrada
│  └─ app.dart        # Setup temático y de navegación global
├─ anexos/            # Imágenes representativas y ejemplos visuales de uso real
```

---

## Flujos y Operativa

### 1. **Venta Online y Offline**
- Los productos, combos y bebidas pueden cargarse desde catálogo o crearse "al vuelo".
- Si no hay red, todos los cambios se almacenan en una cola (`OfflineQueueService`), y se sincronizan automáticamente en cuanto la app detecta conexión.
- El usuario no pierde ninguna venta, ni pedidos personalizados: el sistema garantiza sincronización segura.

### 2. **Gestión de Inventario y Proveedores**
- Altas, bajas, edición y consulta de proveedores y productos.
- Registro automático de entradas y salidas de stock.
- Notificaciones cuando un producto alcanza mínimo de stock.

### 3. **Mapas de Mesas y Logística**
- Selección visual de mesas para pedido.
- Control de estado: libre, ocupada o reservada.
- Vinculación rápida con ventas en progreso.

### 4. **Reportes y Métricas**
- Acceso en app a informes: totales por día, ventas por producto, pendientes por sincronizar, comparativos entre periodos, etc.

### 5. **Autenticación y Seguridad**
- Soporta login mediante JWT.
- Cada operación se asocia al usuario responsable.
- Tokens y datos sensibles encripados localmente.

### 6. **Mensajería y Notificaciones**
- Push locales configurables (nuevo pedido, stock bajo, sincronización exitosa, etc.).
- Mensajes contextuales tipo SnackBar para retroalimentación inmediata.

---

## Anexos

Galería visual (referencial) de características clave:

<table>
  <tr>
    <td align="center">
      <img src="anexos/añadir inventario.jpg" width="220" /><br>añadir inventario
    </td>
    <td align="center">
      <img src="anexos/añadir producto.jpg" width="220" /><br>añadir producto
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="anexos/añadir stock al inventario.jpg" width="220" /><br>añadir stock al inventario
    </td>
    <td align="center">
      <img src="anexos/catálogo productos.jpg" width="220" /><br>catálogo productos
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="anexos/chat ia.jpg" width="220" /><br>chat ia
    </td>
    <td align="center">
      <img src="anexos/chat ia 2.jpg" width="220" /><br>chat ia 2
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="anexos/cola de ventas offline.jpg" width="220" /><br>cola de ventas offline
    </td>
    <td align="center">
      <img src="anexos/cola offline vacia.jpg" width="220" /><br>cola offline vacia
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="anexos/cronometraje de lotes.jpg" width="220" /><br>cronometraje de lotes
    </td>
    <td align="center">
      <img src="anexos/dash.jpg" width="220" /><br>dash
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="anexos/editar ordenes.jpg" width="220" /><br>editar ordenes
    </td>
    <td align="center">
      <img src="anexos/editar proveedore.jpg" width="220" /><br>editar proveedore
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="anexos/editar sucursales.jpg" width="220" /><br>editar sucursales
    </td>
    <td align="center">
      <img src="anexos/eliminar inventario.jpg" width="220" /><br>eliminar inventario
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="anexos/Filtro fecha.jpg" width="220" /><br>Filtro fecha
    </td>
    <td align="center">
      <img src="anexos/inventario.jpg" width="220" /><br>inventario
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="anexos/limpiar cola.jpg" width="220" /><br>limpiar cola
    </td>
    <td align="center">
      <img src="anexos/login.jpg" width="220" /><br>login
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="anexos/logistica envios.jpg" width="220" /><br>logística envíos
    </td>
    <td align="center">
      <img src="anexos/mapa de mesas.jpg" width="220" /><br>mapa de mesas
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="anexos/offline bebida.jpg" width="220" /><br>offline bebida
    </td>
    <td align="center">
      <img src="anexos/offline combo.jpg" width="220" /><br>offline combo
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="anexos/ordenes.jpg" width="220" /><br>órdenes
    </td>
    <td align="center">
      <img src="anexos/proveedores.jpg" width="220" /><br>proveedores
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="anexos/RAG IA.jpg" width="220" /><br>RAG IA
    </td>
    <td align="center">
      <img src="anexos/Reportes.jpg" width="220" /><br>Reportes
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="anexos/sucursales.jpg" width="220" /><br>sucursales
    </td>
    <td align="center">
      <img src="anexos/venta offline.jpg" width="220" /><br>venta offline
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="anexos/venta online bebida personalizada.jpg" width="220" /><br>venta online bebida personalizada
    </td>
    <td align="center">
      <img src="anexos/venta online tamal personalizado.jpg" width="220" /><br>venta online tamal personalizado
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="anexos/venta online vacio.jpg" width="220" /><br>venta online vacío
    </td>
    <td align="center">
      <img src="anexos/venta online.jpg" width="220" /><br>venta online
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="anexos/ventas online producto existente.jpg" width="220" /><br>ventas online producto existente
    </td>
    <td></td>
  </tr>
</table>
