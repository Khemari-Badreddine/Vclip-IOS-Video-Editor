//
//  ContentView.swift
//  Vclip App
//
//  Created by Pedro on 11/1/2024.
//

import SwiftUI

struct SigninView: View {
    
    @State private var isSubscriptionViewPresented = false
    
    var body: some View {
        
        NavigationStack {
            VStack(alignment: .center) {
                Spacer()
                
                Image("vclip icon")
                    
                Text("first screen")
                    .foregroundColor(.white)
                    .font(.title)
                
                NavigationLink(destination: {

                }, label: {
                    Text("Sign In with Google")
                        .frame(maxWidth: .infinity)
                        .background(alignment: .leading){
                            Image("googleicon")
                                .frame(width: 40)
                        }
                })
                .buttonStyle(CustomButtonStyle())
                .padding(.vertical,20)
                
                NavigationLink(destination: {
                    EmailSigninView()

                }, label: {
                    Text("Sign In with Email")
                        .frame(maxWidth: .infinity)
                        .background(alignment: .leading){
                            Image("emailicon")
                                .frame(width: 40)
                        }
                })
                .buttonStyle(CustomButtonStyle())

                
                Spacer()
                
                Text("License")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding(0)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(Color.black)
        }
    }
}

struct CustomButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: 250)
            .padding()
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(.gray, lineWidth: 2)
                    .background(configuration.isPressed ? Color.gray : Color.black)
            )
            .cornerRadius(8)
    }
}


#Preview {
    SigninView()
}



