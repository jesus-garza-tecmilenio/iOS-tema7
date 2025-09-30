//
//  ContentView.swift
//  Tema7Swift
//
//  Created by JESUS GARZA on 30/09/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var coordinator = NavigationCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            MainMenuView()
                .navigationDestination(for: Route.self) { route in
                    destinationView(for: route)
                }
        }
        .environmentObject(coordinator)
    }
    
    @ViewBuilder
    private func destinationView(for route: Route) -> some View {
        switch route {
        case .home:
            MainMenuView()
        case .basicEnums:
            BasicEnumsView()
        case .associatedValueEnums:
            AssociatedValueEnumsView()
        case .switchExamples:
            SwitchExamplesView()
        case .codeRepresentations:
            CodeRepresentationsView()
        case .navigationDemo:
            NavigationDemoView()
        case .exercises:
            ExercisesView()
        case .enumDetail(let enumType):
            EnumDetailView(enumType: enumType)
        case .exerciseDetail(let id):
            ExerciseDetailView(exerciseId: id)
        }
    }
}

#Preview {
    ContentView()
}
