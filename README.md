# Tema 7: Enumeraciones y Navegación en Swift

## Descripción del Proyecto

Este proyecto es una aplicación educativa completa que demuestra los conceptos fundamentales de enumeraciones en Swift y las técnicas avanzadas de navegación en SwiftUI. Está diseñado como material didáctico para clases de programación en Swift.

## Temas Implementados

### 1. Enumeraciones Básicas
- Enums con raw values (String e Int)
- Enums sin raw values
- Protocolo CaseIterable
- Computed properties en enums

### 2. Enumeraciones con Valores Asociados
- Valores asociados múltiples
- Enums anidados
- Enums genéricos
- Pattern matching avanzado

### 3. Switch e If Case
- Extracción de valores asociados
- Pattern matching con condiciones (where)
- If case para casos específicos
- Guard statements con enums

### 4. Códigos y Representaciones
- Códigos de país (ISO)
- Códigos de moneda
- Endpoints de API
- Aplicaciones prácticas

### 5. Navegación en SwiftUI
- NavigationStack
- NavigationPath
- Navegación programática
- Presentaciones modales (Sheet, FullScreenCover)
- Transiciones y animaciones

### 6. Ejercicios Interactivos
- 6 ejercicios graduados por dificultad
- Sistema de progreso
- Hints y ejemplos
- Editor de código integrado

## Estructura del Proyecto

```
Tema7Swift/
├── Models/
│   ├── BasicEnums.swift           # Enumeraciones básicas
│   ├── AssociatedValueEnums.swift # Enums con valores asociados
│   └── NavigationModels.swift     # Modelos de navegación
├── Views/
│   ├── MainMenuView.swift         # Menú principal
│   ├── BasicEnumsView.swift       # Demo de enums básicos
│   ├── AssociatedValueEnumsView.swift # Demo de valores asociados
│   ├── SwitchExamplesView.swift   # Ejemplos de switch/if case
│   ├── CodeRepresentationsView.swift # Códigos y representaciones
│   ├── NavigationDemoView.swift   # Demo de navegación
│   ├── ExercisesView.swift        # Lista de ejercicios
│   ├── ExerciseDetailView.swift   # Detalle de ejercicios
│   └── EnumDetailView.swift       # Análisis detallado de enums
├── ContentView.swift              # Vista principal con NavigationStack
└── Tema7SwiftApp.swift           # Punto de entrada de la app
```

## Requisitos Técnicos

- **iOS 16.0+** (Deployment target mínimo)
- **Swift 5.9+**
- **Xcode 15+**
- Funcionalidades iOS 18+ protegidas con `#available(iOS 18, *)`

## Instrucciones para Ejecutar la Demo en Clase

### 1. Abrir el Proyecto
1. Abre Xcode
2. Selecciona "Open a project or file"
3. Navega a la carpeta del proyecto y selecciona `Tema7Swift.xcodeproj`

### 2. Configurar el Proyecto
1. En el navegador de proyectos, selecciona el proyecto "Tema7Swift"
2. En la pestaña "Signing & Capabilities", selecciona tu equipo de desarrollo
3. Asegúrate de que el deployment target esté configurado en iOS 16.0

### 3. Ejecutar la Demo
1. Selecciona un simulador (iPhone 16 recomendado)
2. Presiona Cmd+R o el botón de "Play" para ejecutar
3. La app se abrirá mostrando el menú principal con 6 secciones

### 4. Navegación por los Temas

#### Para mostrar Enumeraciones Básicas:
- Toca "Enumeraciones Básicas" en el menú principal
- Demuestra los diferentes tipos de enums con los controles interactivos
- Usa los botones "Explorar Detalles" para análisis profundo

#### Para mostrar Valores Asociados:
- Toca "Valores Asociados"
- Demuestra las medidas dinámicas con los botones de colores
- Añade notificaciones para mostrar diferentes tipos
- Simula operaciones para mostrar Result types

#### Para mostrar Switch e If Case:
- Toca "Switch e If Case"
- Cambia códigos HTTP para mostrar switch básico
- Genera medidas aleatorias para mostrar extracción de valores
- Demuestra pattern matching avanzado con las secciones inferiores

#### Para mostrar Códigos y Representaciones:
- Toca "Códigos y Representaciones"
- Cambia países y monedas para mostrar aplicaciones prácticas
- Simula llamadas API
- Muestra el generador QR simulado

#### Para mostrar Navegación:
- Toca "Demo de Navegación"
- Demuestra navegación básica con los botones de enum details
- Usa "Ruta Múltiple" para mostrar navegación programática
- Prueba las presentaciones modales (Sheet y Full Screen)
- Observa la información del path en tiempo real

### 5. Funcionalidades iOS 18 (si están disponibles)
Si ejecutas en iOS 18+, verás una sección adicional "Funciones Avanzadas" que demuestra las nuevas capacidades de navegación.

### 6. Ejercicios para Estudiantes
- Toca "Ejercicios" para mostrar la sección de práctica
- Los estudiantes pueden completar ejercicios graduados
- Cada ejercicio incluye descripción, pasos, editor de código y hints
- Sistema de progreso visual para motivar el aprendizaje

## Transiciones y Animaciones

El proyecto incluye animaciones fluidas en:
- Navegación entre vistas (0.3s ease-in-out)
- Cambios de estado en controles interactivos
- Presentaciones modales
- Actualizaciones de progreso
- Transiciones de contenido dinámico

## Características Destacadas

### Para el Profesor:
- Navegación intuitiva entre todos los conceptos
- Ejemplos interactivos para cada tema
- Código fuente visible y comentado
- Casos de uso prácticos y realistas

### Para los Estudiantes:
- 6 ejercicios progresivos
- Editor de código integrado
- Sistema de hints graduales
- Seguimiento de progreso
- Ejemplos de código ejecutables

## Archivos Clave para Revisar

1. **Models/BasicEnums.swift** - Ejemplos fundamentales de enumeraciones
2. **Models/AssociatedValueEnums.swift** - Casos avanzados con valores asociados
3. **Models/NavigationModels.swift** - Coordinador de navegación y rutas
4. **Views/MainMenuView.swift** - Interfaz principal y estructura de navegación
5. **ContentView.swift** - Implementación de NavigationStack

## Notas para la Presentación

- La app está optimizada para demostración en pantalla grande
- Todos los controles tienen feedback visual inmediato
- Los ejemplos son progresivos: de conceptos simples a avanzados
- El código está estructurado para ser leído y entendido fácilmente
- Incluye casos de uso del mundo real (APIs, códigos de país, etc.)

## Solución de Problemas

Si encuentras errores de compilación:
1. Verifica que el deployment target sea iOS 16.0 o superior
2. Asegúrate de tener Xcode 15+ instalado
3. Limpia el build folder (Cmd+Shift+K) y vuelve a compilar
4. Si hay problemas de firma, configura un equipo de desarrollo válido

El proyecto está listo para usar como material didáctico completo para enseñar enumeraciones y navegación en Swift/SwiftUI.
