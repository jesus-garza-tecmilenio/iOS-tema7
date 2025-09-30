//
//  AssociatedValueEnums.swift
//  Tema7Swift
//
//  Created by JESUS GARZA on 30/09/25.
//

import Foundation

// MARK: - Enumeraciones con Valores Asociados

/// Enumeración para diferentes tipos de medidas
enum Measurement {
    case distance(meters: Double)
    case weight(kilograms: Double)
    case temperature(celsius: Double)
    case time(seconds: Int)
    
    var description: String {
        switch self {
        case .distance(let meters):
            return "\(meters) metros"
        case .weight(let kg):
            return "\(kg) kg"
        case .temperature(let celsius):
            return "\(celsius)°C"
        case .time(let seconds):
            return "\(seconds) segundos"
        }
    }
    
    /// Convierte la medida a una unidad alternativa
    var alternativeUnit: String {
        switch self {
        case .distance(let meters):
            return "\(meters / 1000) km"
        case .weight(let kg):
            return "\(kg * 2.20462) lbs"
        case .temperature(let celsius):
            return "\((celsius * 9/5) + 32)°F"
        case .time(let seconds):
            return "\(seconds / 60) minutos"
        }
    }
}

/// Enumeración para diferentes tipos de notificaciones
enum NotificationType {
    case message(from: String, content: String)
    case reminder(title: String, date: Date)
    case alert(level: AlertLevel, message: String)
    case system(code: Int, info: String)
    
    enum AlertLevel {
        case info, warning, error
        
        var emoji: String {
            switch self {
            case .info: return "ℹ️"
            case .warning: return "⚠️"
            case .error: return "❌"
            }
        }
    }
}

/// Enumeración para resultados de operaciones
enum OperationResult<T> {
    case success(T)
    case failure(ErrorType)
    
    enum ErrorType {
        case networkError(String)
        case validationError(field: String, message: String)
        case unknownError
        
        var description: String {
            switch self {
            case .networkError(let message):
                return "Error de red: \(message)"
            case .validationError(let field, let message):
                return "Error en \(field): \(message)"
            case .unknownError:
                return "Error desconocido"
            }
        }
    }
}

/// Enumeración para códigos de respuesta HTTP
enum HTTPStatusCode: Int, CaseIterable {
    case ok = 200
    case created = 201
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case internalServerError = 500
    
    var category: StatusCategory {
        switch self.rawValue {
        case 200...299: return .success
        case 300...399: return .redirection
        case 400...499: return .clientError
        case 500...599: return .serverError
        default: return .unknown
        }
    }
    
    enum StatusCategory {
        case success, redirection, clientError, serverError, unknown
        
        var description: String {
            switch self {
            case .success: return "Éxito"
            case .redirection: return "Redirección"
            case .clientError: return "Error del cliente"
            case .serverError: return "Error del servidor"
            case .unknown: return "Desconocido"
            }
        }
    }
}