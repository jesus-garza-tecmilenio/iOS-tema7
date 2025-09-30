//
//  ExerciseDetailView.swift
//  Tema7Swift
//
//  Created by JESUS GARZA on 30/09/25.
//

import SwiftUI

struct ExerciseDetailView: View {
    let exerciseId: Int
    @State private var isCompleted = false
    @State private var userCode = ""
    @State private var showHint = false
    @State private var currentStep = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                headerSection
                exerciseDescription
                stepsSection
                codeEditor
                hintsSection
                submissionSection
            }
            .padding()
        }
        .navigationTitle("Ejercicio \(exerciseId)")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            setupExercise()
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading) {
                    Text(exercise.title)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    HStack {
                        DifficultyBadge(difficulty: exercise.difficulty)
                        Spacer()
                        Label(exercise.estimatedTime, systemImage: "clock")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                if isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.green)
                }
            }
            
            Text(exercise.description)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var exerciseDescription: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Descripción del Ejercicio")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(detailedDescription)
                    .font(.body)
                
                if !exercise.topics.isEmpty {
                    Text("Temas cubiertos:")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .padding(.top, 8)
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 8) {
                        ForEach(exercise.topics, id: \.self) { topic in
                            TopicTag(topic: topic)
                        }
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
    
    private var stepsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Pasos a Seguir")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 12) {
                ForEach(exerciseSteps.indices, id: \.self) { index in
                    HStack(alignment: .top, spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(currentStep > index ? Color.green : Color.blue)
                                .frame(width: 24, height: 24)
                            
                            if currentStep > index {
                                Image(systemName: "checkmark")
                                    .font(.caption)
                                    .foregroundColor(.white)
                            } else {
                                Text("\(index + 1)")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(exerciseSteps[index])
                                .font(.caption)
                                .foregroundColor(currentStep >= index ? .primary : .secondary)
                        }
                        
                        Spacer()
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
    
    private var codeEditor: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Tu Solución")
                    .font(.headline)
                
                Spacer()
                
                Button("Ejemplo") {
                    userCode = sampleCode
                }
                .font(.caption)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(16)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                TextEditor(text: $userCode)
                    .font(.system(.body, design: .monospaced))
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .frame(minHeight: 200)
                
                HStack {
                    Button("Verificar Código") {
                        checkCode()
                    }
                    .buttonStyle(ActionButtonStyle(color: .blue))
                    
                    Spacer()
                    
                    Button("Limpiar") {
                        userCode = ""
                    }
                    .font(.caption)
                    .foregroundColor(.red)
                }
            }
        }
    }
    
    private var hintsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Button {
                showHint.toggle()
            } label: {
                HStack {
                    Text("💡 Pistas")
                        .font(.headline)
                    Spacer()
                    Image(systemName: showHint ? "chevron.down" : "chevron.right")
                        .font(.caption)
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            if showHint {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(hints, id: \.self) { hint in
                        HStack(alignment: .top, spacing: 8) {
                            Text("•")
                                .foregroundColor(.blue)
                            Text(hint)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: showHint)
    }
    
    private var submissionSection: some View {
        VStack(spacing: 16) {
            if isCompleted {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text("¡Ejercicio completado!")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(8)
            } else {
                Button("Marcar como Completado") {
                    withAnimation {
                        isCompleted = true
                    }
                }
                .buttonStyle(ActionButtonStyle(color: .green))
            }
        }
    }
    
    // MARK: - Computed Properties
    
    private var exercise: Exercise {
        Exercise.allExercises.first { $0.id == exerciseId } ?? Exercise.placeholder
    }
    
    private var detailedDescription: String {
        switch exerciseId {
        case 1:
            return "Crea un enum llamado 'DayOfWeek' que represente los días de la semana. Incluye raw values en español y una computed property que determine si es fin de semana."
        case 2:
            return "Implementa un enum 'FileType' con valores asociados para diferentes tipos de archivos (documento, imagen, video) incluyendo sus metadatos específicos."
        case 3:
            return "Diseña un enum 'Command' que represente comandos de terminal y usa pattern matching para procesarlos con diferentes parámetros."
        case 4:
            return "Crea un enum genérico 'APIResponse<T>' que maneje respuestas exitosas y diferentes tipos de errores de una API REST."
        case 5:
            return "Implementa un coordinador de navegación usando NavigationStack que maneje múltiples flujos de navegación programática."
        case 6:
            return "Diseña un enum 'AppState' que represente los diferentes estados de una aplicación (loading, loaded, error, empty)."
        default:
            return "Ejercicio de práctica con enumeraciones en Swift."
        }
    }
    
    private var exerciseSteps: [String] {
        switch exerciseId {
        case 1:
            return [
                "Define el enum DayOfWeek con casos para cada día",
                "Añade raw values en español",
                "Implementa CaseIterable",
                "Crea la computed property isWeekend"
            ]
        case 2:
            return [
                "Define FileType con casos para documento, imagen, video",
                "Añade valores asociados apropiados para cada tipo",
                "Implementa métodos para obtener información",
                "Usa switch para manejar cada caso"
            ]
        case 3:
            return [
                "Define Command con diferentes tipos de comandos",
                "Usa valores asociados para parámetros",
                "Implementa pattern matching con switch",
                "Añade guard statements para validación"
            ]
        default:
            return [
                "Analiza el problema",
                "Diseña la estructura del enum",
                "Implementa los métodos necesarios",
                "Prueba tu solución"
            ]
        }
    }
    
    private var hints: [String] {
        switch exerciseId {
        case 1:
            return [
                "Usa String como tipo de raw value",
                "CaseIterable te permitirá iterar sobre todos los casos",
                "La computed property puede usar self == para comparar casos"
            ]
        case 2:
            return [
                "Cada caso puede tener diferentes tipos de valores asociados",
                "Considera qué metadatos son importantes para cada tipo de archivo",
                "Usa switch para extraer los valores asociados"
            ]
        case 3:
            return [
                "Los comandos pueden tener diferentes números de parámetros",
                "Pattern matching con 'where' puede ser útil para validaciones",
                "Guard statements ayudan con la validación temprana"
            ]
        default:
            return [
                "Recuerda los conceptos básicos de enums",
                "Usa pattern matching cuando sea apropiado",
                "Considera usar computed properties para lógica adicional"
            ]
        }
    }
    
    private var sampleCode: String {
        switch exerciseId {
        case 1:
            return """
enum DayOfWeek: String, CaseIterable {
    case monday = "Lunes"
    case tuesday = "Martes"
    case wednesday = "Miércoles"
    case thursday = "Jueves"
    case friday = "Viernes"
    case saturday = "Sábado"
    case sunday = "Domingo"
    
    var isWeekend: Bool {
        return self == .saturday || self == .sunday
    }
}
"""
        case 2:
            return """
enum FileType {
    case document(name: String, pages: Int)
    case image(name: String, resolution: String)
    case video(name: String, duration: TimeInterval)
    
    var displayName: String {
        switch self {
        case .document(let name, _):
            return "📄 \\(name)"
        case .image(let name, _):
            return "🖼️ \\(name)"
        case .video(let name, _):
            return "🎥 \\(name)"
        }
    }
}
"""
        default:
            return "// Escribe tu código aquí\n"
        }
    }
    
    // MARK: - Methods
    
    private func setupExercise() {
        userCode = "// Escribe tu código aquí\n"
    }
    
    private func checkCode() {
        // Simulación de verificación de código
        let hasEnum = userCode.contains("enum")
        let hasSwitch = userCode.contains("switch") || userCode.contains("case")
        
        if hasEnum && hasSwitch {
            currentStep = min(currentStep + 1, exerciseSteps.count)
        }
    }
}

// MARK: - Extensions

extension Exercise {
    static let allExercises = [
        Exercise(id: 1, title: "Enum Básico - Días de la Semana", 
                description: "Crea un enum para representar los días de la semana",
                difficulty: .beginner, estimatedTime: "15 min",
                topics: ["Enums básicos", "Raw values", "Computed properties"]),
        Exercise(id: 2, title: "Valores Asociados - Sistema de Archivos", 
                description: "Implementa un enum para diferentes tipos de archivos",
                difficulty: .intermediate, estimatedTime: "25 min",
                topics: ["Associated values", "Switch", "Pattern matching"]),
        Exercise(id: 3, title: "Pattern Matching - Procesador de Comandos", 
                description: "Crea un sistema de procesamiento de comandos",
                difficulty: .intermediate, estimatedTime: "30 min",
                topics: ["Pattern matching", "If case", "Guard"]),
        Exercise(id: 4, title: "API Response Handler", 
                description: "Diseña un enum para respuestas de API",
                difficulty: .advanced, estimatedTime: "35 min",
                topics: ["Generic enums", "Error handling", "Result"]),
        Exercise(id: 5, title: "Navigation Flow", 
                description: "Implementa navegación con NavigationStack",
                difficulty: .advanced, estimatedTime: "40 min",
                topics: ["NavigationStack", "NavigationPath", "Programmatic"]),
        Exercise(id: 6, title: "Estado de la Aplicación", 
                description: "Crea un enum para estados de app",
                difficulty: .beginner, estimatedTime: "20 min",
                topics: ["App states", "Loading", "Error states"])
    ]
    
    static let placeholder = Exercise(
        id: 0, title: "Ejercicio no encontrado", 
        description: "Este ejercicio no existe",
        difficulty: .beginner, estimatedTime: "0 min", topics: []
    )
}

#Preview {
    NavigationView {
        ExerciseDetailView(exerciseId: 1)
    }
}