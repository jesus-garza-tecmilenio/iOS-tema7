//
//  BasicEnums.swift
//  Tema7Swift
//
//  Created by JESUS GARZA on 30/09/25.
//

import Foundation

// MARK: - Enumeraciones Básicas

/// Enumeración básica para días de la semana
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

/// Enumeración para prioridades
enum Priority: Int, CaseIterable {
    case low = 1
    case medium = 2
    case high = 3
    case urgent = 4
    
    var description: String {
        switch self {
        case .low: return "Baja"
        case .medium: return "Media"
        case .high: return "Alta"
        case .urgent: return "Urgente"
        }
    }
    
    var color: String {
        switch self {
        case .low: return "green"
        case .medium: return "yellow"
        case .high: return "orange"
        case .urgent: return "red"
        }
    }
}

/// Enumeración para estados de conexión
enum ConnectionStatus: CaseIterable {
    case disconnected
    case connecting
    case connected
    case error
    
    var displayText: String {
        switch self {
        case .disconnected: return "Desconectado"
        case .connecting: return "Conectando..."
        case .connected: return "Conectado"
        case .error: return "Error"
        }
    }
}