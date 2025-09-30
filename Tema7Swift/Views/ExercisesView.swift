//
//  ExercisesView.swift
//  Tema7Swift
//
//  Created by JESUS GARZA on 30/09/25.
//

import SwiftUI

struct ExercisesView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    @State private var completedExercises: Set<Int> = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                headerSection
                progressSection
                exercisesList
            }
            .padding()
        }
        .navigationTitle("Ejercicios")
        .navigationBarTitleDisplayMode(.large)
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Práctica para Estudiantes")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Completa estos ejercicios para practicar los conceptos de enumeraciones y navegación en Swift.")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var progressSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Progreso Total")
                    .font(.headline)
                Spacer()
                Text("\(completedExercises.count)/\(exercises.count)")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
            
            ProgressView(value: Double(completedExercises.count), total: Double(exercises.count))
                .tint(.blue)
            
            Text("¡Sigue así! Cada ejercicio completado te acerca más al dominio de los enums.")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
    
    private var exercisesList: some View {
        LazyVStack(spacing: 16) {
            ForEach(exercises, id: \.id) { exercise in
                ExerciseCard(
                    exercise: exercise,
                    isCompleted: completedExercises.contains(exercise.id)
                ) {
                    coordinator.navigate(to: .exerciseDetail(exercise.id))
                } onToggleComplete: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        if completedExercises.contains(exercise.id) {
                            completedExercises.remove(exercise.id)
                        } else {
                            completedExercises.insert(exercise.id)
                        }
                    }
                }
            }
        }
    }
    
    private var exercises: [Exercise] {
        [
            Exercise(
                id: 1,
                title: "Enum Básico - Días de la Semana",
                description: "Crea un enum para representar los días de la semana con métodos útiles.",
                difficulty: .beginner,
                estimatedTime: "15 min",
                topics: ["Enums básicos", "Raw values", "Computed properties"]
            ),
            Exercise(
                id: 2,
                title: "Valores Asociados - Sistema de Archivos",
                description: "Implementa un enum para representar diferentes tipos de archivos con sus metadatos.",
                difficulty: .intermediate,
                estimatedTime: "25 min",
                topics: ["Associated values", "Switch statements", "Pattern matching"]
            ),
            Exercise(
                id: 3,
                title: "Pattern Matching - Procesador de Comandos",
                description: "Crea un sistema que procese comandos usando switch avanzado e if case.",
                difficulty: .intermediate,
                estimatedTime: "30 min",
                topics: ["Pattern matching", "If case", "Guard statements"]
            ),
            Exercise(
                id: 4,
                title: "API Response Handler",
                description: "Diseña un enum para manejar diferentes tipos de respuestas de API.",
                difficulty: .advanced,
                estimatedTime: "35 min",
                topics: ["Generic enums", "Error handling", "Result type"]
            ),
            Exercise(
                id: 5,
                title: "Navigation Flow",
                description: "Implementa un flujo de navegación complejo usando NavigationStack.",
                difficulty: .advanced,
                estimatedTime: "40 min",
                topics: ["NavigationStack", "NavigationPath", "Programmatic navigation"]
            ),
            Exercise(
                id: 6,
                title: "Estado de la Aplicación",
                description: "Crea un enum para manejar los diferentes estados de una aplicación.",
                difficulty: .beginner,
                estimatedTime: "20 min",
                topics: ["App states", "Loading states", "Error states"]
            )
        ]
    }
}

struct Exercise {
    let id: Int
    let title: String
    let description: String
    let difficulty: Difficulty
    let estimatedTime: String
    let topics: [String]
    
    enum Difficulty: String, CaseIterable {
        case beginner = "Principiante"
        case intermediate = "Intermedio"
        case advanced = "Avanzado"
        
        var color: Color {
            switch self {
            case .beginner: return .green
            case .intermediate: return .orange
            case .advanced: return .red
            }
        }
        
        var systemImage: String {
            switch self {
            case .beginner: return "leaf"
            case .intermediate: return "flame"
            case .advanced: return "bolt"
            }
        }
    }
}

struct ExerciseCard: View {
    let exercise: Exercise
    let isCompleted: Bool
    let onTap: () -> Void
    let onToggleComplete: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(exercise.title)
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                        
                        Text(exercise.description)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                    
                    Button(action: onToggleComplete) {
                        Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                            .font(.title2)
                            .foregroundColor(isCompleted ? .green : .gray)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                HStack {
                    DifficultyBadge(difficulty: exercise.difficulty)
                    
                    Spacer()
                    
                    Label(exercise.estimatedTime, systemImage: "clock")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                
                if !exercise.topics.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(exercise.topics, id: \.self) { topic in
                                TopicTag(topic: topic)
                            }
                        }
                        .padding(.horizontal, 1)
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isCompleted ? Color.green : Color.clear, lineWidth: 2)
            )
            .scaleEffect(isCompleted ? 0.98 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct DifficultyBadge: View {
    let difficulty: Exercise.Difficulty
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: difficulty.systemImage)
                .font(.caption2)
            Text(difficulty.rawValue)
                .font(.caption2)
                .fontWeight(.medium)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(difficulty.color.opacity(0.2))
        .foregroundColor(difficulty.color)
        .cornerRadius(12)
    }
}

struct TopicTag: View {
    let topic: String
    
    var body: some View {
        Text(topic)
            .font(.caption2)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color(.systemGray5))
            .foregroundColor(.primary)
            .cornerRadius(8)
    }
}

#Preview {
    NavigationView {
        ExercisesView()
            .environmentObject(NavigationCoordinator())
    }
}