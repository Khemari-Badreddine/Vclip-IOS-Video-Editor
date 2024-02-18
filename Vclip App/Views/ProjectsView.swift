//
//  ProjectsView.swift
//  Vclip App
//
//  Created by Pedro on 1/2/2024.
//

import SwiftUI


struct Item: Identifiable {
    var id: UUID
    var projectimage: String
    var projectname: String
    var creationdate: String
}

struct ProjectsView: View {
    
    var items = [Item(id: UUID(),projectimage: "subimg", projectname:                           "Travel tips",creationdate:"23/07/2023"),
                 Item(id: UUID(),projectimage: "projectimg", projectname:                           "Flow Lifestyle",creationdate:"23/07/2023"),
                 Item(id: UUID(),projectimage: "subimg", projectname:                           "Family time",creationdate:"21/03/2024"),]
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 20){
                
                HStack{
                    
                    Text("VCLIP")
                        .foregroundColor(.white)
                        .font(.title3)
                    
                    Spacer()
                    
                    Text("GO PRO")
                        .foregroundStyle(gradient)
                        .font(.title3)
                    
                    
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(.white)
                        .font(.system(size: 26))
                }
                
                HStack(alignment: .center){
                    
                    customselectbutton(iconname: "camera",name: "Camera")
                    customselectbutton(iconname: "play.rectangle",name: "Stock videos")
                    customselectbutton(iconname: "visionpro",name: "AI images")
                    
                    
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                
                Button(
                    action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/,
                    label: {
                        VStack{
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .padding()
                                .background(
                                    ZStack { // Apply background to the combined view
                                        Circle()
                                            .fill(.gray.opacity(0.5)) // Fill the circle with gray
                                        Circle()
                                            .strokeBorder(.gray, lineWidth: 2) // Add the stroke
                                    }
                                )
                                .font(.system(size: 18))
                            
                            Text("New project")
                                .foregroundColor(.white)
                            
                        }
                    })
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: 120)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .strokeBorder(.gray, lineWidth: 2)
                        .opacity(0.5)
                )
                
                Text("My projects")
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment:.leading)
                    .foregroundColor(.white)
                    .font(.title2)
                
                ScrollView {
                    LazyVStack{
                        ForEach(items) { item in
                            myprojectsview(projectimage: item.projectimage,
                                           projectname: item.projectname,
                                           creationdate: item.creationdate)
                        }
                    }
                }
                
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
            .background(.black)
            .navigationBarHidden(true)
        }
        
    }
}

struct myprojectsview: View {
    
    let projectimage: String
    let projectname: String
    let creationdate: String
    
    var body: some View {
        NavigationLink(
            destination: {VideoEditorView()},
            label: {
                HStack(){
                    Image(projectimage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 115)
                        .cornerRadius(4)
                        .padding(.vertical,40)
                    
                    
                    
                    VStack(alignment: .leading){
                        Text(projectname)
                            .foregroundColor(.white)
                        Text(creationdate)
                            .foregroundColor(.gray)
                            .font(.caption)
                        
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Image(systemName: "ellipsis")
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            ZStack { // Apply background to the combined view
                                Circle()
                                    .fill(.gray.opacity(0.3)) // Fill the circle with gray
                                
                            }
                        )
                        .frame(maxHeight: .infinity,alignment:.top)
                        .font(.system(size: 22))
                }
                .padding()
            })
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: 150)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(.gray, lineWidth: 2)
                .opacity(0.5)
                .background(Color("Colorprojects"))
        )
        .cornerRadius(15)
        
    }
}

private struct customselectbutton: View {
    
    let iconname: String
    let name: String
    
    var body: some View {
        
        Button (
            action: {
                
            },
            
            label: {
                VStack{
                    Image(systemName: iconname)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            ZStack { // Apply background to the combined view
                                Circle()
                                    .fill(Color("Colorgreyish")) // Fill the circle with gray
                                Circle()
                                    .strokeBorder(.gray, lineWidth: 2) // Add the stroke
                            }
                        )
                        .font(.system(size: 22))
                    
                    Text(name)
                        .foregroundColor(.gray)
                    
                }
            })
        
        
    }
}


#Preview {
    ProjectsView()
}
