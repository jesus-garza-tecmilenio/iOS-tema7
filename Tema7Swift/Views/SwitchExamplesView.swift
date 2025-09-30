//
//  SwitchExamplesView.swift
//  Tema7Swift
//
//  Created by JESUS GARZA on 30/09/25.
//

import SwiftUI

struct SwitchExamplesView: View {
    @State private var selectedMeasurement: Measurement = .distance(meters: 500)
    @State private var selectedNotification: NotificationType = .message(from: "Pedro", content: "Hola mundo")
    @State private var httpResponse: HTTPStatusCode = .ok
    @State private var extractedInfo: String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                headerSection
                switchWithBasicEnumSection
                switchWithAssociatedValuesSection
                ifCaseExamplesSection
                patternMatchingSection
            }
            .padding()
        }
        .navigationTitle("Switch e If Case")
        .navigationBarTitleDisplayMode(.large)
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Extracción de Valores")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Swift proporciona patrones poderosos para extraer y trabajar con valores de enumeraciones usando switch e if case.")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var switchWithBasicEnumSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("1. Switch con Enums Básicos")
                .font(.headline)
            
            VStack(spacing: 12) {
                Picker("Código HTTP", selection: $httpResponse) {
                    ForEach(HTTPStatusCode.allCases, id: \.self) { code in
                        Text("\(code.rawValue)").tag(code)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Análisis del código:")
                        .fontWeight(.medium)
                    
                    Text(analyzeHTTPStatus(httpResponse))
                        .padding()
                        .background(backgroundColorForStatus(httpResponse))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    private var switchWithAssociatedValuesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("2. Switch con Valores Asociados")
                .font(.headline)
            
            VStack(spacing: 12) {
                HStack {
                    Button("Distancia") {
                        selectedMeasurement = .distance(meters: Double.random(in: 100...10000))
                        updateMeasurementInfo()
                    }
                    .buttonStyle(ActionButtonStyle(color: .blue))
                    
                    Button("Peso") {
                        selectedMeasurement = .weight(kilograms: Double.random(in: 0.5...200))
                        updateMeasurementInfo()
                    }
                    .buttonStyle(ActionButtonStyle(color: .green))
                    
                    Button("Temperatura") {
                        selectedMeasurement = .temperature(celsius: Double.random(in: -20...50))
                        updateMeasurementInfo()
                    }
                    .buttonStyle(ActionButtonStyle(color: .orange))
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Extracción con switch:")
                        .fontWeight(.medium)
                    
                    Text(extractedInfo)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .font(.system(.body, design: .monospaced))
                }
            }
        }
    }
    
    private var ifCaseExamplesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("3. If Case para Casos Específicos")
                .font(.headline)
            
            VStack(spacing: 12) {
                HStack {
                    Button("Mensaje") {
                        selectedNotification = .message(
                            from: ["Ana", "Carlos", "María"].randomElement()!,
                            content: ["¡Hola!", "¿Cómo estás?", "¿Nos vemos?"].randomElement()!
                        )
                    }
                    .buttonStyle(ActionButtonStyle(color: .purple))
                    
                    Button("Alerta") {
                        let levels: [NotificationType.AlertLevel] = [.info, .warning, .error]
                        let messages = ["Sistema actualizado", "Memoria baja", "Error crítico"]
                        selectedNotification = .alert(
                            level: levels.randomElement()!,
                            message: messages.randomElement()!
                        )
                    }
                    .buttonStyle(ActionButtonStyle(color: .red))
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Verificación con if case:")
                        .fontWeight(.medium)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(checkIfMessage())
                        Text(checkIfAlert())
                        Text(checkIfSystem())
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .font(.caption)
                }
            }
        }
    }
    
    private var patternMatchingSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("4. Pattern Matching Avanzado")
                .font(.headline)
            
            VStack(spacing: 12) {
                Text("Ejemplos de patrones complejos:")
                    .fontWeight(.medium)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("• Rangos de temperatura:")
                    Text(classifyTemperature())
                        .foregroundColor(.blue)
                        .padding(.leading)
                    
                    Text("• Filtrado de mensajes:")
                    Text(filterMessages())
                        .foregroundColor(.green)
                        .padding(.leading)
                    
                    Text("• Categorización HTTP:")
                    Text(categorizeHTTPResponse())
                        .foregroundColor(.orange)
                        .padding(.leading)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .font(.caption)
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func analyzeHTTPStatus(_ status: HTTPStatusCode) -> String {
        switch status {
        case .ok:
            return "✅ Solicitud exitosa"
        case .created:
            return "✅ Recurso creado correctamente"
        case .badRequest:
            return "❌ Solicitud malformada"
        case .unauthorized:
            return "🔒 Autenticación requerida"
        case .forbidden:
            return "🚫 Acceso prohibido"
        case .notFound:
            return "📭 Recurso no encontrado"
        case .internalServerError:
            return "💥 Error interno del servidor"
        }
    }
    
    private func backgroundColorForStatus(_ status: HTTPStatusCode) -> Color {
        switch status.category {
        case .success:
            return .green
        case .redirection:
            return .blue
        case .clientError:
            return .orange
        case .serverError:
            return .red
        case .unknown:
            return .gray
        }
    }
    
    private func updateMeasurementInfo() {
        switch selectedMeasurement {
        case .distance(let meters):
            extractedInfo = "case .distance(let meters):\n  meters = \(meters)\n  En km: \(meters/1000)"
        case .weight(let kg):
            extractedInfo = "case .weight(let kilograms):\n  kilograms = \(kg)\n  En libras: \(kg * 2.20462)"
        case .temperature(let celsius):
            extractedInfo = "case .temperature(let celsius):\n  celsius = \(celsius)\n  En Fahrenheit: \((celsius * 9/5) + 32)"
        case .time(let seconds):
            extractedInfo = "case .time(let seconds):\n  seconds = \(seconds)\n  En minutos: \(seconds/60)"
        }
    }
    
    private func checkIfMessage() -> String {
        if case .message(let from, let content) = selectedNotification {
            return "✅ Es mensaje de \(from): '\(content)'"
        } else {
            return "❌ No es un mensaje"
        }
    }
    
    private func checkIfAlert() -> String {
        if case .alert(let level, let message) = selectedNotification {
            return "⚠️ Es alerta \(level.emoji): '\(message)'"
        } else {
            return "❌ No es una alerta"
        }
    }
    
    private func checkIfSystem() -> String {
        if case .system(let code, _) = selectedNotification {
            return "⚙️ Es notificación del sistema (código: \(code))"
        } else {
            return "❌ No es notificación del sistema"
        }
    }
    
    private func classifyTemperature() -> String {
        switch selectedMeasurement {
        case .temperature(let celsius) where celsius < 0:
            return "Bajo cero (\(celsius)°C)"
        case .temperature(let celsius) where celsius > 30:
            return "Caluroso (\(celsius)°C)"
        case .temperature(let celsius):
            return "Templado (\(celsius)°C)"
        default:
            return "No es temperatura"
        }
    }
    
    private func filterMessages() -> String {
        switch selectedNotification {
        case .message(let from, _) where from.count > 4:
            return "Mensaje de nombre largo: \(from)"
        case .message(let from, let content) where content.contains("?"):
            return "Pregunta de \(from)"
        case .message(let from, _):
            return "Mensaje simple de \(from)"
        default:
            return "No es mensaje"
        }
    }
    
    private func categorizeHTTPResponse() -> String {
        switch httpResponse.category {
        case .success:
            return "Categoría: Éxito (\(httpResponse.rawValue))"
        case .clientError:
            return "Categoría: Error del cliente (\(httpResponse.rawValue))"
        case .serverError:
            return "Categoría: Error del servidor (\(httpResponse.rawValue))"
        default:
            return "Categoría: Otra (\(httpResponse.rawValue))"
        }
    }
}

struct ActionButtonStyle: ButtonStyle {
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.caption)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(configuration.isPressed ? color.opacity(0.7) : color)
            .foregroundColor(.white)
            .cornerRadius(16)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

#Preview {
    NavigationView {
        SwitchExamplesView()
    }
}