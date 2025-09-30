//
//  NavigationModels.swift
//  Tema7Swift
//
//  Created by JESUS GARZA on 30/09/25.
//

import Foundation
import SwiftUI

// MARK: - Modelos para Navegación

/// Enumeración para rutas de navegación
enum Route: Hashable {
    case home
    case basicEnums
    case associatedValueEnums
    case switchExamples
    case codeRepresentations
    case navigationDemo
    case exercises
    case enumDetail(EnumType)
    case exerciseDetail(Int)
    
    /// Tipos de enumeraciones para el detalle
    enum EnumType: String, CaseIterable, Hashable {
        case dayOfWeek = "DayOfWeek"
        case priority = "Priority"
        case connection = "ConnectionStatus"
        case measurement = "Measurement"
        case notification = "NotificationType"
        case httpStatus = "HTTPStatusCode"
        
        var displayName: String {
            switch self {
            case .dayOfWeek: return "Días de la Semana"
            case .priority: return "Prioridades"
            case .connection: return "Estado de Conexión"
            case .measurement: return "Medidas"
            case .notification: return "Notificaciones"
            case .httpStatus: return "Códigos HTTP"
            }
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Inicio"
        case .basicEnums: return "Enumeraciones Básicas"
        case .associatedValueEnums: return "Valores Asociados"
        case .switchExamples: return "Switch e If Case"
        case .codeRepresentations: return "Códigos y Representaciones"
        case .navigationDemo: return "Demo de Navegación"
        case .exercises: return "Ejercicios"
        case .enumDetail(let type): return type.displayName
        case .exerciseDetail(let id): return "Ejercicio \(id)"
        }
    }
    
    var systemImage: String {
        switch self {
        case .home: return "house"
        case .basicEnums: return "list.bullet"
        case .associatedValueEnums: return "folder"
        case .switchExamples: return "arrow.triangle.branch"
        case .codeRepresentations: return "barcode"
        case .navigationDemo: return "map"
        case .exercises: return "graduationcap"
        case .enumDetail: return "info.circle"
        case .exerciseDetail: return "pencil"
        }
    }
    
    // Casos disponibles para navegación básica (sin parámetros)
    static var basicCases: [Route] {
        return [.home, .basicEnums, .associatedValueEnums, .switchExamples,
                .codeRepresentations, .navigationDemo, .exercises]
    }
}

/// Clase para manejar el estado de navegación
@MainActor
class NavigationCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var currentRoute: Route = .home
    
    /// Navega a una ruta específica
    func navigate(to route: Route) {
        path.append(route)
        currentRoute = route
    }
    
    /// Regresa a la vista anterior
    func goBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    /// Regresa al inicio
    func goToRoot() {
        path = NavigationPath()
        currentRoute = .home
    }
    
    /// Navega programáticamente con múltiples rutas
    func navigateToPath(_ routes: [Route]) {
        path = NavigationPath()
        for route in routes {
            path.append(route)
        }
        if let lastRoute = routes.last {
            currentRoute = lastRoute
        }
    }
}
