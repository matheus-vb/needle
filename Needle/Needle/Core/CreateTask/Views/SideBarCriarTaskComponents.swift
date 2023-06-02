//
//  SideBarCriarTaskComponents.swift
//  Needle
//
//  Created by gabrielfelipo on 01/06/23.
//
import Foundation
import SwiftUI

extension SideBarCriarTask {
    
    
    var titleSideBarCriarTask: some View {
        
        VStack{
            Spacer().frame(minHeight: 28, idealHeight: 82, maxHeight: 82)
            HStack{
                Spacer().frame(idealWidth: 87)
                Text("Atributos")
                    .font(.custom(.spaceGroteskBold, size: 24))
                
                Spacer().frame(idealWidth: 250)
                
                Image(systemName: "rectangle.3.group.fill")
                    .resizable()
                    .frame(width: 36, height: 24)
                    .foregroundColor(Color.color.mainGreen)
                
                Spacer().frame(idealWidth: 100)
            }
            Spacer().frame(height: 30)
        }
    }
    
    struct CriarButtonStyle: ButtonStyle {
        let fontColor: Color
        let bgColor: Color
        
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .frame(width: 120, height: 40)
                .foregroundColor(fontColor)
                .background(bgColor)
                .cornerRadius(4)
                
        }
    }
    
    struct menuCriarTaskStyle: MenuStyle {
        func makeBody(configuration: Configuration) -> some View {
            Menu(configuration)
                .foregroundColor(.white)
                .background(.black, in: RoundedRectangle(cornerRadius: 4, style: .continuous))
                .frame(width: 150)
        }
    }
    
    enum dropdownType: CaseIterable {
        case status
        case area
        case membro
    }
    
    enum status: String, CaseIterable {
        case toDo = "to do"
        case inProgress = "in progress"
        case inReviw = "in review"
        case done = "done"
    }
    
    enum area: String, CaseIterable {
        case dev = "DEV"
        case design = "DESIGN"
        case geral = "GENERAL"
    }
    
    
    var attributeDropdownStatus: some View {
        Menu{
            
            ForEach (status.allCases, id: \.self){ statusCase in
                
                Button(statusCase.rawValue){
                    statusChoice = statusCase.rawValue
                    updateStatus(newStatus: statusCase.rawValue)
                }
            }
        } label: {
            ZStack{
                
                Text(statusChoice)
                    .font(.custom(.spaceGroteskBold, size: 13))
                
            }.frame(width: 50, height: 100)
        }.menuStyle(menuCriarTaskStyle())
    }
    
    var attributeDropdownArea: some View {
        Menu{
            
            ForEach (area.allCases, id: \.self){ areaCase in
                Button(action: {
                    areaChoice = areaCase.rawValue
                    updateArea(newArea: areaCase.rawValue)
                    
                }, label: {
                    Text(areaCase.rawValue)
                })
            }
            
            
        } label: {
            ZStack{
                
                Text(areaChoice)
                    .font(.custom(.spaceGroteskBold, size: 13))
                
            }.frame(width: 50, height: 100)
        }.menuStyle(menuCriarTaskStyle())
    }
    
    var attributeDropdownMember: some View {
        Menu{
            Button(action: {
                memberChoice = "ninguém"
                updateMember(newMemberId: nil)
                
            }, label: {
                Text("ninguém")
            })
            
            ForEach (workspace.users, id: \.self){ userCase in
                Button(action: {
                    memberChoice = userCase.name
                    updateMember(newMemberId: userCase.id)
                    
                }, label: {
                    Text(userCase.name)
                })
            }
            
            
        } label: {
            ZStack{
                
                Text(memberChoice)
                    .font(.custom(.spaceGroteskBold, size: 13))
                
            }.frame(width: 50, height: 100)
        }.menuStyle(menuCriarTaskStyle())
    }
    
    func updateStatus(newStatus: String) {
        newTask.status = newStatus
    }
    
    func updateArea(newArea: String) {
        newTask.type = newArea
    }
    
    func updateMember(newMemberId: String?) {
        newTask.userId = newMemberId
    }
}
