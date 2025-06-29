# Características de Accesibilidad - Cronômetro de Voltas

Este documento describe las características de accesibilidad implementadas en la aplicación Cronômetro de Voltas para garantizar la inclusión de usuarios con diferentes capacidades.

## Características Implementadas

### 1. Widget Semantics
- **Descripción**: Uso extensivo del widget `Semantics` para proporcionar información accesible a lectores de pantalla
- **Implementación**: 
  - Etiquetas descriptivas para todos los botones
  - Descripciones detalladas para el cronómetro y lista de voltas
  - Estados dinámicos (habilitado/deshabilitado) comunicados a lectores de pantalla
  - Información contextual para cada elemento de la interfaz

### 2. Colores de Alto Contraste
- **Descripción**: Paleta de colores diseñada para proporcionar contraste adecuado
- **Colores implementados**:
  - Azul primario: `#1565C0` (azul oscuro)
  - Azul secundario: `#1976D2` (azul medio)
  - Verde de éxito: `#2E7D32` (verde oscuro)
  - Naranja de advertencia: `#F57C00` (naranja oscuro)
  - Rojo de error: `#D32F2F` (rojo oscuro)
  - Texto primario: `#212121` (negro suave)
  - Texto secundario: `#424242` (gris oscuro)

### 3. Tamaños de Fuente Accesibles
- **Descripción**: Tamaños de fuente que cumplen con las recomendaciones de accesibilidad
- **Tamaños implementados**:
  - Pequeño: 16px (mínimo recomendado)
  - Mediano: 18px
  - Grande: 20px
  - Extra grande: 24px
  - Título: 36px
  - Display: 48px

### 4. Espaciado de Letras
- **Descripción**: Espaciado optimizado para mejorar la legibilidad
- **Valores implementados**:
  - Ajustado: 0.1
  - Normal: 0.2
  - Amplio: 0.5
  - Extra amplio: 1.0

### 5. Tamaños de Botones Accesibles
- **Descripción**: Botones con tamaño mínimo para facilitar la interacción táctil
- **Especificaciones**:
  - Tamaño mínimo: 120x56 píxeles
  - Área de toque mínimo: 44x44 píxeles
  - Padding adecuado para evitar toques accidentales

### 6. Estructura Semántica
- **Descripción**: Organización lógica de la interfaz para navegación eficiente
- **Elementos**:
  - AppBar con título descriptivo
  - Sección principal del cronómetro
  - Controles organizados en grupos lógicos
  - Lista de voltas con información estructurada

### 7. Información Contextual
- **Descripción**: Descripciones detalladas para lectores de pantalla
- **Ejemplos**:
  - "Botão para iniciar o cronômetro"
  - "Tempo atual: 2 minutos, 15 segundos e 3 décimos de segundo"
  - "Volta número 3. Tempo da volta: 1 minuto, 30 segundos e 5 décimos"

## Archivos de Configuración

### `lib/core/accessibility/accessibility_config.dart`
- Configuración centralizada de accesibilidad
- Constantes para colores, tamaños y espaciados
- Métodos utilitarios para crear elementos accesibles
- Tema completo accesible

### `lib/views/cronometro_view.dart`
- Implementación de Semantics en todos los elementos
- Estructura semántica mejorada
- Descripciones detalladas para lectores de pantalla

### `lib/main.dart`
- Aplicación del tema accesible global
- Configuración de la aplicación para accesibilidad

## Beneficios para Usuarios

### Usuarios con Discapacidad Visual
- Lectores de pantalla pueden interpretar correctamente toda la información
- Contraste adecuado facilita la lectura
- Tamaños de fuente apropiados para ampliación

### Usuarios con Discapacidad Motora
- Botones con tamaño adecuado para facilitar el toque
- Espaciado suficiente entre elementos
- Áreas de toque amplias

### Usuarios con Discapacidad Cognitiva
- Interfaz clara y organizada
- Información presentada de forma lógica
- Estados claramente comunicados

## Cumplimiento de Estándares

La aplicación cumple con las siguientes recomendaciones:
- **WCAG 2.1**: Nivel AA
- **Material Design Accessibility**: Guías de accesibilidad
- **Flutter Accessibility**: Mejores prácticas de Flutter

## Pruebas de Accesibilidad

Para verificar la accesibilidad:
1. Activar lectores de pantalla (TalkBack en Android, VoiceOver en iOS)
2. Navegar por la aplicación usando gestos de accesibilidad
3. Verificar que toda la información sea comunicada correctamente
4. Probar con diferentes tamaños de fuente del sistema
5. Verificar contraste con herramientas de análisis de color

## Mantenimiento

Para mantener la accesibilidad:
- Revisar regularmente las descripciones de Semantics
- Actualizar colores según nuevas recomendaciones
- Probar con usuarios reales cuando sea posible
- Mantener documentación actualizada 