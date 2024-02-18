//
//  SubscriptionView.swift
//  Vclip App
//
//  Created by Pedro on 29/1/2024.
//

import SwiftUI

let gradient = LinearGradient(
    colors: [Color("color1"),Color("color2")],
    startPoint: .topLeading,
    endPoint: .bottomTrailing
)

struct SubscriptionView: View {
    
    var body: some View {
        NavigationStack{
            
            ZStack(alignment: .topLeading){
                
                VStack(alignment: .leading){
                    Image("subimg")
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity,maxHeight:.infinity)
                .background(Color.black)
                
                VStack(alignment: .center){
                    
                    Image(systemName: "xmark")
                        .frame(maxWidth: .infinity,maxHeight:150
                               ,alignment: .topTrailing)
                        .foregroundColor(.white)
                        .font(.title)
                    
                    
                    Text("GO PRO")
                        .frame(maxWidth: .infinity,maxHeight: 200,alignment: .bottom)
                        .foregroundStyle(gradient)
                        .padding(.top,20)
                    
                    Text("Unlock")
                        .frame(maxWidth: 270,alignment:.center)
                        .foregroundColor(.white)
                        .font(.title)
                        .multilineTextAlignment(.center)
                    
                    
                    NavigationLink(
                        destination: {
                            ProjectsView()
                        }, label: {
                            VStack{
                                Text("Free trial / 7 days")
                                    .frame(maxWidth: .infinity)
                                
                                Text("Cancel anytime")
                                    .frame(maxWidth: .infinity)
                                    .font(.caption2)
                            }
                            
                        })
                    .buttonStyle(CustomButton(Colorname: "Colorgreyish"))
                    .padding(.vertical,20)
                    
                    
                    NavigationLink(
                        destination: {
                            ProjectsView()
                        }, label: {
                            VStack{
                                Text("Subscribe / 8,99 weekly")
                                    .frame(maxWidth: .infinity)
                                
                                Text("Save 60%")
                                    .frame(maxWidth: .infinity)
                                    .font(.caption2)
                            }
                            
                        })
                    .buttonStyle(CustomButton(Colorname: ""))
                    
                }
                .frame(maxWidth: .infinity,maxHeight:.infinity)
                .padding(20)
                
                
                
            }
            .edgesIgnoringSafeArea(.all)
            .frame(maxWidth: .infinity,maxHeight:.infinity)
            .navigationBarBackButtonHidden(true)}
        
    }
    
    
    
}


struct CustomButton: ButtonStyle {
    
    var Colorname:String
    
    init(Colorname: String) {
        self.Colorname = Colorname
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity,maxHeight: 50)
            .padding()
            .foregroundColor(.white)
            .background(
                
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(.gray, lineWidth: 2)
                    .background(configuration.isPressed ? Color.gray : Color(Colorname))
            )
            .background(gradient)
            .cornerRadius(8)
    }
    
}
#Preview {
    SubscriptionView()
}
