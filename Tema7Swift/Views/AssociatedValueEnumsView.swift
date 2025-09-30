//
//  AssociatedValueEnumsView.swift
//  Tema7Swift
//
//  Created by JESUS GARZA on 30/09/25.
//

import SwiftUI

struct AssociatedValueEnumsView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    @State private var selectedMeasurement: Measurement = .distance(meters: 1000)
    @State private var notifications: [NotificationType] = []
    @State private var operationResults: [String] = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                headerSection
                measurementSection
                notificationSection
                operationResultSection
            }
            .padding()
        }
        .navigationTitle("Valores Asociados")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            setupInitialData()
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Enums con Datos Asociados")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Los valores asociados permiten almacenar información adicional junto con cada caso de la enumeración.")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var measurementSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("1. Measurement Enum")
                .font(.headline)
            
            VStack(spacing: 12) {
                HStack {
                    Button("Distancia") {
                        selectedMeasurement = .distance(meters: Double.random(in: 100...5000))
                    }
                    .buttonStyle(MeasurementButtonStyle())
                    
                    Button("Peso") {
                        selectedMeasurement = .weight(kilograms: Double.random(in: 1...100))
                    }
                    .buttonStyle(MeasurementButtonStyle())
                }
                
                HStack {
                    Button("Temperatura") {
                        selectedMeasurement = .temperature(celsius: Double.random(in: -10...40))
                    }
                    .buttonStyle(MeasurementButtonStyle())
                    
                    Button("Tiempo") {
                        selectedMeasurement = .time(seconds: Int.random(in: 60...3600))
                    }
                    .buttonStyle(MeasurementButtonStyle())
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Medida actual:")
                            .fontWeight(.medium)
                        Spacer()
                        Text(selectedMeasurement.description)
                            .foregroundColor(.blue)
                    }
                    
                    HStack {
                        Text("Unidad alternativa:")
                            .fontWeight(.medium)
                        Spacer()
                        Text(selectedMeasurement.alternativeUnit)
                            .foregroundColor(.green)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
        }
    }
    
    private var notificationSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("2. NotificationType Enum")
                    .font(.headline)
                Spacer()
                Button("Añadir Notif.") {
                    addRandomNotification()
                }
                .font(.caption)
            }
            
            if notifications.isEmpty {
                Text("No hay notificaciones")
                    .foregroundColor(.secondary)
                    .italic()
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            } else {
                LazyVStack(spacing: 8) {
                    ForEach(notifications.indices, id: \.self) { index in
                        NotificationCard(notification: notifications[index]) {
                            notifications.remove(at: index)
                        }
                    }
                }
            }
        }
    }
    
    private var operationResultSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("3. OperationResult<T> Enum")
                    .font(.headline)
                Spacer()
                Button("Simular Op.") {
                    simulateOperation()
                }
                .font(.caption)
            }
            
            if operationResults.isEmpty {
                Text("No hay resultados")
                    .foregroundColor(.secondary)
                    .italic()
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            } else {
                LazyVStack(spacing: 8) {
                    ForEach(operationResults.indices, id: \.self) { index in
                        HStack {
                            Text(operationResults[index])
                                .font(.caption)
                            Spacer()
                            Button("Eliminar") {
                                operationResults.remove(at: index)
                            }
                            .font(.caption2)
                            .foregroundColor(.red)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color(.systemGray6))
                        .cornerRadius(6)
                    }
                }
            }
        }
    }
    
    private func setupInitialData() {
        notifications = [
            .message(from: "Juan", content: "¡Hola! ¿Cómo estás?"),
            .reminder(title: "Reunión", date: Date().addingTimeInterval(3600))
        ]
    }
    
    private func addRandomNotification() {
        let randomNotifications: [NotificationType] = [
            .message(from: "Ana", content: "¿Nos vemos mañana?"),
            .reminder(title: "Llamar al médico", date: Date().addingTimeInterval(7200)),
            .alert(level: .warning, message: "Batería baja"),
            .alert(level: .error, message: "Error de conexión"),
            .system(code: 101, info: "Actualización disponible")
        ]
        
        if let randomNotif = randomNotifications.randomElement() {
            withAnimation(.easeInOut(duration: 0.3)) {
                notifications.append(randomNotif)
            }
        }
    }
    
    private func simulateOperation() {
        let operations: [OperationResult<String>] = [
            .success("Datos guardados correctamente"),
            .failure(.networkError("Sin conexión a internet")),
            .failure(.validationError(field: "email", message: "Formato inválido")),
            .success("Usuario autenticado"),
            .failure(.unknownError)
        ]
        
        if let randomOp = operations.randomElement() {
            let resultText: String
            switch randomOp {
            case .success(let message):
                resultText = "✅ Éxito: \(message)"
            case .failure(let error):
                resultText = "❌ Error: \(error.description)"
            }
            
            withAnimation(.easeInOut(duration: 0.3)) {
                operationResults.insert(resultText, at: 0)
            }
        }
    }
}

struct MeasurementButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.caption)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(configuration.isPressed ? Color.blue.opacity(0.8) : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(20)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct NotificationCard: View {
    let notification: NotificationType
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(titleForNotification)
                    .font(.caption)
                    .fontWeight(.medium)
                
                Text(contentForNotification)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button("×") {
                onDelete()
            }
            .foregroundColor(.red)
            .font(.title3)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
    
    private var titleForNotification: String {
        switch notification {
        case .message(let from, _):
            return "💬 Mensaje de \(from)"
        case .reminder(let title, _):
            return "⏰ Recordatorio: \(title)"
        case .alert(let level, _):
            return "\(level.emoji) Alerta \(levelText(level))"
        case .system(let code, _):
            return "⚙️ Sistema (\(code))"
        }
    }
    
    private var contentForNotification: String {
        switch notification {
        case .message(_, let content):
            return content
        case .reminder(_, let date):
            return "Programado para \(DateFormatter.localizedString(from: date, dateStyle: .none, timeStyle: .short))"
        case .alert(_, let message):
            return message
        case .system(_, let info):
            return info
        }
    }
    
    private func levelText(_ level: NotificationType.AlertLevel) -> String {
        switch level {
        case .info: return "Info"
        case .warning: return "Advertencia"
        case .error: return "Error"
        }
    }
}

#Preview {
    NavigationView {
        AssociatedValueEnumsView()
            .environmentObject(NavigationCoordinator())
    }
}