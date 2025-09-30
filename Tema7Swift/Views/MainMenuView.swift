//
//  MainMenuView.swift
//  Tema7Swift
//
//  Created by JESUS GARZA on 30/09/25.
//

import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 20) {
                    ForEach(menuItems, id: \.route) { item in
                        MenuCard(item: item)
                    }
                }
                .padding()
            }
            .navigationTitle("Tema 7: Enums y Navegación")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private var menuItems: [MenuItem] {
        [
            MenuItem(
                route: .basicEnums,
                title: "Enumeraciones Básicas",
                description: "Conceptos fundamentales de enums",
                systemImage: "list.bullet",
                color: .blue
            ),
            MenuItem(
                route: .associatedValueEnums,
                title: "Valores Asociados",
                description: "Enums con datos adicionales",
                systemImage: "folder",
                color: .green
            ),
            MenuItem(
                route: .switchExamples,
                title: "Switch e If Case",
                description: "Extracción de valores",
                systemImage: "arrow.triangle.branch",
                color: .orange
            ),
            MenuItem(
                route: .codeRepresentations,
                title: "Códigos y Representaciones",
                description: "Aplicaciones prácticas",
                systemImage: "barcode",
                color: .purple
            ),
            MenuItem(
                route: .navigationDemo,
                title: "Demo de Navegación",
                description: "NavigationStack y transiciones",
                systemImage: "map",
                color: .red
            ),
            MenuItem(
                route: .exercises,
                title: "Ejercicios",
                description: "Práctica para estudiantes",
                systemImage: "graduationcap",
                color: .indigo
            )
        ]
    }
}

struct MenuItem {
    let route: Route
    let title: String
    let description: String
    let systemImage: String
    let color: Color
}

struct MenuCard: View {
    let item: MenuItem
    @EnvironmentObject var coordinator: NavigationCoordinator
    
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.3)) {
                coordinator.navigate(to: item.route)
            }
        } label: {
            VStack(spacing: 12) {
                Image(systemName: item.systemImage)
                    .font(.system(size: 40, weight: .medium))
                    .foregroundColor(item.color)
                
                VStack(spacing: 4) {
                    Text(item.title)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    
                    Text(item.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 120)
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    MainMenuView()
        .environmentObject(NavigationCoordinator())
}