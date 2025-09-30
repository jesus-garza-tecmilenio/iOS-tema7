//
//  NavigationDemoView.swift
//  Tema7Swift
//
//  Created by JESUS GARZA on 30/09/25.
//

import SwiftUI

struct NavigationDemoView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    @State private var showingSheet = false
    @State private var showingFullScreen = false
    @State private var selectedTab = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                headerSection
                navigationStackSection
                programmaticNavigationSection
                modalPresentationSection
                tabNavigationSection
                pathInfoSection
                
                if #available(iOS 18.0, *) {
                    advancedFeaturesSection
                }
            }
            .padding()
        }
        .navigationTitle("Demo de Navegación")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showingSheet) {
            SheetDemoView()
        }
        .fullScreenCover(isPresented: $showingFullScreen) {
            FullScreenDemoView()
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("NavigationStack y Transiciones")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Demostración de las capacidades de navegación en SwiftUI con NavigationStack, NavigationPath y presentaciones modales.")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var navigationStackSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("1. NavigationStack Básico")
                .font(.headline)
            
            VStack(spacing: 12) {
                Text("Navegación push/pop tradicional:")
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 12) {
                    ForEach(Route.EnumType.allCases, id: \.self) { enumType in
                        NavigationButton(
                            title: enumType.displayName,
                            systemImage: "info.circle",
                            color: .blue
                        ) {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                coordinator.navigate(to: .enumDetail(enumType))
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var programmaticNavigationSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("2. Navegación Programática")
                .font(.headline)
            
            VStack(spacing: 12) {
                Text("Control del NavigationPath:")
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 12) {
                    NavigationButton(
                        title: "Ruta Múltiple",
                        systemImage: "arrow.turn.down.right",
                        color: .green
                    ) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            coordinator.navigateToPath([
                                .basicEnums,
                                .enumDetail(.dayOfWeek)
                            ])
                        }
                    }
                    
                    NavigationButton(
                        title: "Ir al Inicio",
                        systemImage: "house",
                        color: .orange
                    ) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            coordinator.goToRoot()
                        }
                    }
                    
                    NavigationButton(
                        title: "Atrás",
                        systemImage: "arrow.left",
                        color: .purple
                    ) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            coordinator.goBack()
                        }
                    }
                    
                    NavigationButton(
                        title: "Ejercicios",
                        systemImage: "graduationcap",
                        color: .red
                    ) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            coordinator.navigate(to: .exercises)
                        }
                    }
                }
            }
        }
    }
    
    private var modalPresentationSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("3. Presentaciones Modales")
                .font(.headline)
            
            VStack(spacing: 12) {
                Text("Sheets y FullScreenCovers:")
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 12) {
                    NavigationButton(
                        title: "Sheet",
                        systemImage: "rectangle.portrait.bottomhalf.inset.filled",
                        color: .indigo
                    ) {
                        showingSheet = true
                    }
                    
                    NavigationButton(
                        title: "Full Screen",
                        systemImage: "rectangle.inset.filled",
                        color: .teal
                    ) {
                        showingFullScreen = true
                    }
                }
            }
        }
    }
    
    private var tabNavigationSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("4. Tab Navigation Simulado")
                .font(.headline)
            
            VStack(spacing: 12) {
                Picker("Tab", selection: $selectedTab) {
                    Text("Enums").tag(0)
                    Text("Navegación").tag(1)
                    Text("Ejercicios").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Group {
                    switch selectedTab {
                    case 0:
                        TabContentView(
                            title: "Contenido de Enums",
                            color: .blue,
                            items: ["Básicos", "Asociados", "Switch"]
                        )
                    case 1:
                        TabContentView(
                            title: "Contenido de Navegación",
                            color: .green,
                            items: ["Stack", "Path", "Modales"]
                        )
                    case 2:
                        TabContentView(
                            title: "Contenido de Ejercicios",
                            color: .orange,
                            items: ["Principiante", "Intermedio", "Avanzado"]
                        )
                    default:
                        EmptyView()
                    }
                }
                .animation(.easeInOut(duration: 0.3), value: selectedTab)
            }
        }
    }
    
    private var pathInfoSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("5. Información del Path")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Ruta actual:")
                        .fontWeight(.medium)
                    Spacer()
                    Text(coordinator.currentRoute.title)
                        .foregroundColor(.blue)
                }
                
                HStack {
                    Text("Profundidad:")
                        .fontWeight(.medium)
                    Spacer()
                    Text("\(coordinator.path.count)")
                        .foregroundColor(.green)
                }
                
                HStack {
                    Text("¿Puede retroceder?")
                        .fontWeight(.medium)
                    Spacer()
                    Text(coordinator.path.isEmpty ? "No" : "Sí")
                        .foregroundColor(coordinator.path.isEmpty ? .red : .green)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .font(.caption)
        }
    }
    
    @available(iOS 18.0, *)
    private var advancedFeaturesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("6. Funciones Avanzadas (iOS 18+)")
                .font(.headline)
            
            VStack(spacing: 12) {
                Text("Características disponibles en iOS 18:")
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 8) {
                    FeatureRow(
                        icon: "sparkles",
                        title: "Transiciones Mejoradas",
                        description: "Animaciones más fluidas"
                    )
                    FeatureRow(
                        icon: "wand.and.rays",
                        title: "Navegación Inteligente",
                        description: "Predicción de rutas"
                    )
                    FeatureRow(
                        icon: "brain.head.profile",
                        title: "Context Awareness",
                        description: "Navegación contextual"
                    )
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
        }
    }
}

struct NavigationButton: View {
    let title: String
    let systemImage: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: systemImage)
                    .font(.title2)
                    .foregroundColor(color)
                
                Text(title)
                    .font(.caption)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, minHeight: 70)
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct TabContentView: View {
    let title: String
    let color: Color
    let items: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(color)
            
            ForEach(items, id: \.self) { item in
                HStack {
                    Circle()
                        .fill(color)
                        .frame(width: 6, height: 6)
                    Text(item)
                        .font(.caption)
                    Spacer()
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.purple)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                Text(description)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
    }
}

struct SheetDemoView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Image(systemName: "rectangle.portrait.bottomhalf.inset.filled")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                Text("Demo de Sheet")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Esta es una presentación modal tipo sheet. Es ideal para formularios, configuraciones o contenido secundario que no requiere toda la pantalla.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                Button("Cerrar") {
                    dismiss()
                }
                .buttonStyle(ActionButtonStyle(color: .blue))
            }
            .padding()
            .navigationTitle("Sheet Modal")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FullScreenDemoView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.purple, .blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Image(systemName: "rectangle.inset.filled")
                    .font(.system(size: 60))
                    .foregroundColor(.white)
                
                Text("Demo Full Screen")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Esta es una presentación a pantalla completa. Ideal para experiencias inmersivas, onboarding o flujos importantes.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.horizontal)
                
                Button("Cerrar") {
                    dismiss()
                }
                .buttonStyle(ActionButtonStyle(color: .white))
            }
            .padding()
        }
    }
}

#Preview {
    NavigationView {
        NavigationDemoView()
            .environmentObject(NavigationCoordinator())
    }
}