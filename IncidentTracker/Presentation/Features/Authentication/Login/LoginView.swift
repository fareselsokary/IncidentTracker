//
//  LoginView.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel
    @EnvironmentObject var appRouter: AppRouter

    var body: some View {
        VStack(spacing: 40) {
            Text("Login")
                .font(.largeTitle)
                .bold()

            VStack(spacing: 24) {
                TextField("Enter your email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)

                Button(action: {
                    viewModel.login()
                }) {
                    Text("Login")
                        .font(.body)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(10)
                        .opacity(viewModel.canLogin ? 1 : 0.5)
                }
                .disabled(!viewModel.canLogin)
            }
            .padding()
            .background(.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 15))

            Spacer()
        }
        .padding(.all, 16)
        .padding(.top, 40)
        .toast($viewModel.message)
        .loading(isLoading: viewModel.isLoading)
        .onChange(of: viewModel.isLoading) { oldValue, newValue in
            if newValue == true {
                appRouter.push(destination: .optVerification(email: viewModel.email))
            }
        }
    }
}

#Preview {
    LoginView(viewModel:
        LoginViewModel(loginUseCase:
            LoginUseCase(repository: AuthenticationRepository()
            )
        ))
}
