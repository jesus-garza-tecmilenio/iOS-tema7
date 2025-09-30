//
//  EnumDetailView.swift
//  Tema7Swift
//
//  Created by JESUS GARZA on 30/09/25.
//

import SwiftUI

struct EnumDetailView: View {
    let enumType: Route.EnumType
    @State private var selectedExample: Int = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                headerSection
                codeExampleSection
                interactiveSection
                implementationNotesSection
            }
            .padding()
        }
        .navigationTitle(enumType.displayName)
        .navigationBarTitleDisplayMode(.large)
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Análisis Detallado")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text(descriptionForEnum)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var codeExampleSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Implementación")
                .font(.headline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                Text(codeForEnum)
                    .font(.system(.caption, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
        }
    }
    
    private var interactiveSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Ejemplo Interactivo")
                .font(.headline)
            
            Group {
                switch enumType {
                case .dayOfWeek:
                    DayOfWeekDemo()
                case .priority:
                    PriorityDemo()
                case .connection:
                    ConnectionDemo()
                case .measurement:
                    MeasurementDemo()
                case .notification:
                    NotificationDemo()
                case .httpStatus:
                    HTTPStatusDemo()
                }
            }
        }
    }
    
    private var implementationNotesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Notas de Implementación")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 12) {
                ForEach(implementationNotes, id: \.self) { note in
                    HStack(alignment: .top, spacing: 8) {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 6, height: 6)
                            .padding(.top, 6)
                        
                        Text(note)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
    
    private var descriptionForEnum: String {
        switch enumType {
        case .dayOfWeek:
            return "DayOfWeek demuestra un enum con raw values de tipo String y computed properties para lógica adicional."
        case .priority:
            return "Priority muestra un enum con raw values numéricos y métodos para obtener descripciones y colores asociados."
        case .connection:
            return "ConnectionStatus es un enum simple sin raw values que representa estados de conectividad."
        case .measurement:
            return "Measurement es un enum con valores asociados que puede almacenar diferentes tipos de medidas con sus valores."
        case .notification:
            return "NotificationType demuestra enums anidados y valores asociados complejos para diferentes tipos de notificaciones."
        case .httpStatus:
            return "HTTPStatusCode combina raw values con computed properties para categorizar códigos de respuesta HTTP."
        }
    }
    
    private var codeForEnum: String {
        switch enumType {
        case .dayOfWeek:
            return """
            enum DayOfWeek: String, CaseIterable {
                case monday = "Lunes"
                case tuesday = "Martes"
                // ...
                
                var isWeekend: Bool {
                    return self == .saturday || self == .sunday
                }
            }
            """
        case .priority:
            return """
            enum Priority: Int, CaseIterable {
                case low = 1
                case medium = 2
                case high = 3
                case urgent = 4
                
                var description: String {
                    switch self {
                    case .low: return "Baja"
                    // ...
                    }
                }
            }
            """
        case .connection:
            return """
            enum ConnectionStatus: CaseIterable {
                case disconnected
                case connecting
                case connected
                case error
                
                var displayText: String {
                    switch self {
                    case .disconnected: return "Desconectado"
                    // ...
                    }
                }
            }
            """
        case .measurement:
            return """
            enum Measurement {
                case distance(meters: Double)
                case weight(kilograms: Double)
                case temperature(celsius: Double)
                case time(seconds: Int)
                
                var description: String {
                    switch self {
                    case .distance(let meters):
                        return "\\(meters) metros"
                    // ...
                    }
                }
            }
            """
        case .notification:
            return """
            enum NotificationType {
                case message(from: String, content: String)
                case reminder(title: String, date: Date)
                case alert(level: AlertLevel, message: String)
                case system(code: Int, info: String)
                
                enum AlertLevel {
                    case info, warning, error
                }
            }
            """
        case .httpStatus:
            return """
            enum HTTPStatusCode: Int, CaseIterable {
                case ok = 200
                case created = 201
                case badRequest = 400
                // ...
                
                var category: StatusCategory {
                    switch self.rawValue {
                    case 200...299: return .success
                    // ...
                    }
                }
            }
            """
        }
    }
    
    private var implementationNotes: [String] {
        switch enumType {
        case .dayOfWeek:
            return [
                "CaseIterable permite iterar sobre todos los casos del enum",
                "Raw values de String facilitan la localización",
                "Computed properties añaden lógica de negocio"
            ]
        case .priority:
            return [
                "Raw values numéricos facilitan comparaciones y ordenamiento",
                "Switch exhaustivo garantiza que todos los casos estén cubiertos",
                "Métodos adicionales encapsulan la lógica de presentación"
            ]
        case .connection:
            return [
                "Enum simple sin raw values para estados discretos",
                "Ideal para máquinas de estado simples",
                "CaseIterable útil para UI y testing"
            ]
        case .measurement:
            return [
                "Valores asociados permiten almacenar datos específicos",
                "Cada caso puede tener diferentes tipos de datos",
                "Pattern matching extrae los valores asociados"
            ]
        case .notification:
            return [
                "Enums anidados organizan tipos relacionados",
                "Valores asociados múltiples en un solo caso",
                "Estructura flexible para diferentes tipos de datos"
            ]
        case .httpStatus:
            return [
                "Combina raw values con computed properties",
                "Categorización automática basada en rangos",
                "Útil para manejar respuestas de red"
            ]
        }
    }
}

// MARK: - Interactive Demo Components

struct DayOfWeekDemo: View {
    @State private var selectedDay: DayOfWeek = .monday
    
    var body: some View {
        VStack(spacing: 12) {
            Picker("Día", selection: $selectedDay) {
                ForEach(DayOfWeek.allCases, id: \.self) { day in
                    Text(day.rawValue).tag(day)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 100)
            
            Text("¿Es fin de semana? \(selectedDay.isWeekend ? "Sí" : "No")")
                .font(.caption)
                .foregroundColor(selectedDay.isWeekend ? .green : .orange)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

struct PriorityDemo: View {
    @State private var selectedPriority: Priority = .medium
    
    var body: some View {
        VStack(spacing: 12) {
            Picker("Prioridad", selection: $selectedPriority) {
                ForEach(Priority.allCases, id: \.self) { priority in
                    Text(priority.description).tag(priority)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            HStack {
                Text("Valor: \(selectedPriority.rawValue)")
                Spacer()
                Circle()
                    .fill(colorForPriority(selectedPriority))
                    .frame(width: 20, height: 20)
            }
            .font(.caption)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
    
    private func colorForPriority(_ priority: Priority) -> Color {
        switch priority.color {
        case "green": return .green
        case "yellow": return .yellow
        case "orange": return .orange
        case "red": return .red
        default: return .gray
        }
    }
}

struct ConnectionDemo: View {
    @State private var status: ConnectionStatus = .disconnected
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                ForEach(ConnectionStatus.allCases, id: \.self) { connectionStatus in
                    Button(connectionStatus.displayText) {
                        withAnimation {
                            status = connectionStatus
                        }
                    }
                    .font(.caption2)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(status == connectionStatus ? Color.blue : Color(.systemGray5))
                    .foregroundColor(status == connectionStatus ? .white : .primary)
                    .cornerRadius(8)
                }
            }
            
            Text("Estado actual: \(status.displayText)")
                .font(.caption)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

struct MeasurementDemo: View {
    @State private var measurement: Measurement = .distance(meters: 1000)
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Button("Distancia") { measurement = .distance(meters: 1500) }
                Button("Peso") { measurement = .weight(kilograms: 75) }
                Button("Temperatura") { measurement = .temperature(celsius: 25) }
                Button("Tiempo") { measurement = .time(seconds: 3600) }
            }
            .font(.caption2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Principal: \(measurement.description)")
                Text("Alternativo: \(measurement.alternativeUnit)")
            }
            .font(.caption)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

struct NotificationDemo: View {
    @State private var notification: NotificationType = .message(from: "Ana", content: "Hola")
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Button("Mensaje") {
                    notification = .message(from: "Carlos", content: "¿Cómo estás?")
                }
                Button("Recordatorio") {
                    notification = .reminder(title: "Reunión", date: Date())
                }
                Button("Alerta") {
                    notification = .alert(level: .warning, message: "Batería baja")
                }
            }
            .font(.caption2)
            
            Text(descriptionForNotification)
                .font(.caption)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
    
    private var descriptionForNotification: String {
        switch notification {
        case .message(let from, let content):
            return "💬 \(from): \(content)"
        case .reminder(let title, _):
            return "⏰ \(title)"
        case .alert(let level, let message):
            return "\(level.emoji) \(message)"
        case .system(let code, let info):
            return "⚙️ [\(code)] \(info)"
        }
    }
}

struct HTTPStatusDemo: View {
    @State private var status: HTTPStatusCode = .ok
    
    var body: some View {
        VStack(spacing: 12) {
            Picker("Código HTTP", selection: $status) {
                ForEach(HTTPStatusCode.allCases, id: \.self) { code in
                    Text("\(code.rawValue)").tag(code)
                }
            }
            .pickerStyle(MenuPickerStyle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Código: \(status.rawValue)")
                Text("Categoría: \(status.category.description)")
            }
            .font(.caption)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

#Preview {
    NavigationView {
        EnumDetailView(enumType: .dayOfWeek)
    }
}