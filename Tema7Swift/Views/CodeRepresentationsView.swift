//
//  CodeRepresentationsView.swift
//  Tema7Swift
//
//  Created by JESUS GARZA on 30/09/25.
//

import SwiftUI

struct CodeRepresentationsView: View {
    @State private var selectedCountryCode: CountryCode = .spain
    @State private var selectedCurrency: Currency = .euro
    @State private var selectedAPIEndpoint: APIEndpoint = .users
    @State private var responseData: String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                headerSection
                countryCodesSection
                currencySection
                apiEndpointsSection
                qrCodeSection
            }
            .padding()
        }
        .navigationTitle("Códigos y Representaciones")
        .navigationBarTitleDisplayMode(.large)
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Aplicaciones Prácticas")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Los enums son ideales para representar códigos, identificadores y constantes del sistema de manera type-safe.")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var countryCodesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("1. Códigos de País (ISO)")
                .font(.headline)
            
            VStack(spacing: 12) {
                Picker("País", selection: $selectedCountryCode) {
                    ForEach(CountryCode.allCases, id: \.self) { country in
                        HStack {
                            Text(country.flag)
                            Text(country.name)
                        }.tag(country)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                VStack(alignment: .leading, spacing: 8) {
                    InfoRow(label: "Código ISO:", value: selectedCountryCode.rawValue)
                    InfoRow(label: "Nombre:", value: selectedCountryCode.name)
                    InfoRow(label: "Bandera:", value: selectedCountryCode.flag)
                    InfoRow(label: "Código telefónico:", value: selectedCountryCode.phoneCode)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
        }
    }
    
    private var currencySection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("2. Códigos de Moneda")
                .font(.headline)
            
            VStack(spacing: 12) {
                Picker("Moneda", selection: $selectedCurrency) {
                    ForEach(Currency.allCases, id: \.self) { currency in
                        HStack {
                            Text(currency.symbol)
                            Text(currency.name)
                        }.tag(currency)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                VStack(alignment: .leading, spacing: 8) {
                    InfoRow(label: "Código:", value: selectedCurrency.rawValue)
                    InfoRow(label: "Nombre:", value: selectedCurrency.name)
                    InfoRow(label: "Símbolo:", value: selectedCurrency.symbol)
                    InfoRow(label: "Ejemplo:", value: selectedCurrency.format(amount: 1234.56))
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
        }
    }
    
    private var apiEndpointsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("3. Endpoints de API")
                .font(.headline)
            
            VStack(spacing: 12) {
                Picker("Endpoint", selection: $selectedAPIEndpoint) {
                    ForEach(APIEndpoint.allCases, id: \.self) { endpoint in
                        Text(endpoint.description).tag(endpoint)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                VStack(alignment: .leading, spacing: 8) {
                    InfoRow(label: "Ruta:", value: selectedAPIEndpoint.path)
                    InfoRow(label: "Método:", value: selectedAPIEndpoint.method.rawValue)
                    InfoRow(label: "Descripción:", value: selectedAPIEndpoint.description)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                
                Button("Simular Petición") {
                    simulateAPICall()
                }
                .buttonStyle(ActionButtonStyle(color: .blue))
                
                if !responseData.isEmpty {
                    Text("Respuesta simulada:")
                        .fontWeight(.medium)
                    
                    Text(responseData)
                        .font(.system(.caption, design: .monospaced))
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
            }
        }
    }
    
    private var qrCodeSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("4. Generación de Códigos")
                .font(.headline)
            
            VStack(spacing: 12) {
                Text("Datos para QR:")
                    .fontWeight(.medium)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("País: \(selectedCountryCode.name)")
                    Text("Moneda: \(selectedCurrency.name)")
                    Text("API: \(selectedAPIEndpoint.path)")
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .font(.caption)
                
                // Simulación de QR Code
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [.black, .gray],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 120, height: 120)
                    .cornerRadius(8)
                    .overlay(
                        Text("QR")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    )
            }
        }
    }
    
    private func simulateAPICall() {
        let sampleResponses = [
            "{ \"status\": \"success\", \"data\": [...] }",
            "{ \"users\": [\"Alice\", \"Bob\", \"Charlie\"] }",
            "{ \"posts\": [{ \"id\": 1, \"title\": \"Hello\" }] }",
            "{ \"error\": \"Not found\", \"code\": 404 }"
        ]
        
        withAnimation(.easeInOut) {
            responseData = sampleResponses.randomElement() ?? ""
        }
    }
}

// MARK: - Supporting Enums

enum CountryCode: String, CaseIterable {
    case spain = "ES"
    case france = "FR"
    case germany = "DE"
    case italy = "IT"
    case portugal = "PT"
    case uk = "GB"
    case usa = "US"
    case mexico = "MX"
    
    var name: String {
        switch self {
        case .spain: return "España"
        case .france: return "Francia"
        case .germany: return "Alemania"
        case .italy: return "Italia"
        case .portugal: return "Portugal"
        case .uk: return "Reino Unido"
        case .usa: return "Estados Unidos"
        case .mexico: return "México"
        }
    }
    
    var flag: String {
        switch self {
        case .spain: return "🇪🇸"
        case .france: return "🇫🇷"
        case .germany: return "🇩🇪"
        case .italy: return "🇮🇹"
        case .portugal: return "🇵🇹"
        case .uk: return "🇬🇧"
        case .usa: return "🇺🇸"
        case .mexico: return "🇲🇽"
        }
    }
    
    var phoneCode: String {
        switch self {
        case .spain: return "+34"
        case .france: return "+33"
        case .germany: return "+49"
        case .italy: return "+39"
        case .portugal: return "+351"
        case .uk: return "+44"
        case .usa: return "+1"
        case .mexico: return "+52"
        }
    }
}

enum Currency: String, CaseIterable {
    case euro = "EUR"
    case dollar = "USD"
    case pound = "GBP"
    case yen = "JPY"
    case peso = "MXN"
    
    var name: String {
        switch self {
        case .euro: return "Euro"
        case .dollar: return "Dólar estadounidense"
        case .pound: return "Libra esterlina"
        case .yen: return "Yen japonés"
        case .peso: return "Peso mexicano"
        }
    }
    
    var symbol: String {
        switch self {
        case .euro: return "€"
        case .dollar: return "$"
        case .pound: return "£"
        case .yen: return "¥"
        case .peso: return "$"
        }
    }
    
    func format(amount: Double) -> String {
        switch self {
        case .euro:
            return String(format: "%.2f€", amount)
        case .dollar:
            return String(format: "$%.2f", amount)
        case .pound:
            return String(format: "£%.2f", amount)
        case .yen:
            return String(format: "¥%.0f", amount)
        case .peso:
            return String(format: "$%.2f MXN", amount)
        }
    }
}

enum APIEndpoint: CaseIterable {
    case users
    case posts
    case comments
    case auth
    case profile
    
    var path: String {
        switch self {
        case .users: return "/api/users"
        case .posts: return "/api/posts"
        case .comments: return "/api/comments"
        case .auth: return "/api/auth"
        case .profile: return "/api/profile"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .users, .posts, .comments, .profile: return .GET
        case .auth: return .POST
        }
    }
    
    var description: String {
        switch self {
        case .users: return "Obtener usuarios"
        case .posts: return "Obtener publicaciones"
        case .comments: return "Obtener comentarios"
        case .auth: return "Autenticación"
        case .profile: return "Perfil de usuario"
        }
    }
}

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE, PATCH
}

struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .fontWeight(.medium)
            Spacer()
            Text(value)
                .foregroundColor(.blue)
        }
        .font(.caption)
    }
}

#Preview {
    NavigationView {
        CodeRepresentationsView()
    }
}