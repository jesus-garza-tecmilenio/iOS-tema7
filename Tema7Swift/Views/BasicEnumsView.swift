//
//  BasicEnumsView.swift
//  Tema7Swift
//
//  Created by JESUS GARZA on 30/09/25.
//

import SwiftUI

struct BasicEnumsView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    @State private var selectedDay: DayOfWeek = .monday
    @State private var selectedPriority: Priority = .medium
    @State private var connectionStatus: ConnectionStatus = .disconnected
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                headerSection
                dayOfWeekSection
                prioritySection
                connectionSection
                enumDetailsSection
            }
            .padding()
        }
        .navigationTitle("Enumeraciones Básicas")
        .navigationBarTitleDisplayMode(.large)
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Conceptos Fundamentales")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Las enumeraciones definen un tipo común para un grupo de valores relacionados, permitiendo trabajar con esos valores de manera type-safe.")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var dayOfWeekSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("1. Enum con Raw Values (String)")
                .font(.headline)
            
            VStack(spacing: 12) {
                Picker("Día de la semana", selection: $selectedDay) {
                    ForEach(DayOfWeek.allCases, id: \.self) { day in
                        Text(day.rawValue).tag(day)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 120)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Valor seleccionado:")
                            .fontWeight(.medium)
                        Spacer()
                        Text(selectedDay.rawValue)
                            .foregroundColor(.blue)
                    }
                    
                    HStack {
                        Text("¿Es fin de semana?")
                            .fontWeight(.medium)
                        Spacer()
                        Text(selectedDay.isWeekend ? "Sí" : "No")
                            .foregroundColor(selectedDay.isWeekend ? .green : .orange)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
        }
    }
    
    private var prioritySection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("2. Enum con Raw Values (Int)")
                .font(.headline)
            
            VStack(spacing: 12) {
                Picker("Prioridad", selection: $selectedPriority) {
                    ForEach(Priority.allCases, id: \.self) { priority in
                        HStack {
                            Circle()
                                .fill(colorForPriority(priority))
                                .frame(width: 12, height: 12)
                            Text(priority.description)
                        }
                        .tag(priority)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Descripción:")
                            .fontWeight(.medium)
                        Spacer()
                        Text(selectedPriority.description)
                            .foregroundColor(.primary)
                    }
                    
                    HStack {
                        Text("Valor numérico:")
                            .fontWeight(.medium)
                        Spacer()
                        Text("\(selectedPriority.rawValue)")
                            .foregroundColor(.blue)
                    }
                    
                    HStack {
                        Text("Color asociado:")
                            .fontWeight(.medium)
                        Spacer()
                        Circle()
                            .fill(colorForPriority(selectedPriority))
                            .frame(width: 20, height: 20)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
        }
    }
    
    private var connectionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("3. Enum sin Raw Values")
                .font(.headline)
            
            VStack(spacing: 12) {
                HStack {
                    ForEach(ConnectionStatus.allCases, id: \.self) { status in
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                connectionStatus = status
                            }
                        } label: {
                            Text(status.displayText)
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(connectionStatus == status ? Color.blue : Color(.systemGray5))
                                .foregroundColor(connectionStatus == status ? .white : .primary)
                                .cornerRadius(16)
                        }
                    }
                }
                
                HStack {
                    Circle()
                        .fill(colorForConnection(connectionStatus))
                        .frame(width: 16, height: 16)
                    
                    Text("Estado actual: \(connectionStatus.displayText)")
                        .fontWeight(.medium)
                    
                    Spacer()
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
        }
    }
    
    private var enumDetailsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Explorar Detalles")
                .font(.headline)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                ForEach(Route.EnumType.allCases.prefix(3), id: \.self) { enumType in
                    Button {
                        coordinator.navigate(to: .enumDetail(enumType))
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: "info.circle")
                                .font(.title2)
                                .foregroundColor(.blue)
                            
                            Text(enumType.displayName)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity, minHeight: 80)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
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
    
    private func colorForConnection(_ status: ConnectionStatus) -> Color {
        switch status {
        case .disconnected: return .gray
        case .connecting: return .yellow
        case .connected: return .green
        case .error: return .red
        }
    }
}

#Preview {
    NavigationView {
        BasicEnumsView()
            .environmentObject(NavigationCoordinator())
    }
}