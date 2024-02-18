//
//  ContentView.swift
//  Vclip App
//
//  Created by Pedro on 11/1/2024.
//

import SwiftUI

struct EmailSigninView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var isEmailValid = false
    
    var body: some View {
        
        GeometryReader{geometry in
            NavigationStack {
                ZStack {
                    VStack(alignment: .center) {
                        Image("vclip icon")
                            .frame(maxWidth: .infinity,
                                   maxHeight: geometry.size.height * 0.3)
                        
                        Text("Sign In to Vclip")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                        
                        CustomTextField(bindingString: $email,text: "Enter email")
                            .onChange(of: email, { oldValue, newValue in
                                isEmailValid = isValidEmail(newValue)
                                
                            })
                            .overlay(
                                email.isEmpty || isEmailValid ? nil :
                                    RoundedRectangle(cornerRadius: 8)
                                    .strokeBorder(.red, lineWidth: 2)
                            )
                            .padding(.bottom,10)
                        
                        CustomTextField(bindingString: $password,text: "Enter password")
                        
                        NavigationLink(
                            destination: {
                                SubscriptionView()
                            }, label: {
                                Text("Sign in")
                                    .frame(maxWidth: .infinity)
                                    .font(.title2)
                            })
                        .buttonStyle(
                            CustomButton(Colorname: ""))
                        .frame(width: 210,height: 50)
                        .padding(.vertical,40)
                        
                        Spacer()
                        HStack{

                            NavigationLink(
                                destination: {
                                    SigninView()},
                                label:{
                                    Text("Dont have an account ?")
                                        .multilineTextAlignment(.center)
                                        .padding(0)
                                    
                                })
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(50)
                    .background(Color.black)
                }
                .navigationBarHidden(true)

            }
            
        }
        
        
    }
}

func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

struct CustomTextField: View {
    
    @Binding var bindingString: String
    let text: String
    
    var body: some View {
        
        if text == "Enter password" {
            SecureField(text: $bindingString, label: {
                Text(text)
                    .foregroundColor(.gray)
            })
            .frame(maxWidth: 250)
            .foregroundColor(.white)
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(.gray, lineWidth: 2)
                    .background(Color.black)
            )
        }
        else{
            TextField(text: $bindingString, label: {
                Text(text)
                    .foregroundColor(.gray)
            })
            .frame(maxWidth: 250)
            .foregroundColor(.white)
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(.gray, lineWidth: 2)
                    .background(Color.black)
            )
        }
    }
    
}


#Preview {
    EmailSigninView()
}



