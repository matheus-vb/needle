//
//  ProjectsViewRightSideComponents.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import SwiftUI

extension ProjectsViewRightSideComponent{
    
    var topContainer: some View {
        HStack{
            buttonsContainer
            Spacer()
            inviteMemberButton
        }
    }
    var buttonsContainer: some View {
        HStack(spacing: 48){
            Button(action: {
                print("Kanban Button")
            }, label: {
                Text("Kanbar")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.black)
            })
            .buttonStyle(.plain)
            
            Button(action: {
                print("Documentation Button")
            }, label: {
                Text("Documentação")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.black)
            })
            .buttonStyle(.plain)
        }
    }
    
    var inviteMemberButton: some View {
        Button(action: {
            print("Convidar membro button")
        }, label: {
            HStack(spacing: 8){
                Image("paperplane")
                Text("Convidar Membro")
            }
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.black)
            .padding([.leading, .trailing], 14)
            .padding([.top, .bottom], 10)
            .background(Color("main-green"))
        })
        .overlay(
            Rectangle()
                .stroke(style: StrokeStyle(lineWidth: 1))
                .foregroundColor(.black)
        )
        .buttonStyle(.plain)
    }
}
