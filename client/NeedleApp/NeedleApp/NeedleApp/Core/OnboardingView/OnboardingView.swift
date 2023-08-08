//
//  OnboardingView.swift
//  NeedleApp
//
//  Created by aaav on 02/08/23.
//

import SwiftUI
import Foundation


struct OnboardingPage : Identifiable, Equatable {
    
    let id = UUID()
    let title : String
    let message : String
    let image : String
    let num : Int
    
    static var samplePage : OnboardingPage = OnboardingPage(
        title: "Task concluída é\ntask documentada.",
        message: "Use o clássico kanban de um modo novo: toda task requer documentação para ser concluída, aprovada pelo criador do workspace.",
        image: "star",
        num: 0)
    
    static var samplePages : [OnboardingPage] =  [
        OnboardingPage(
            title: "Task concluída é\ntask documentada.",
            message: "Use o clássico kanban de um modo novo: toda task requer documentação para ser concluída, aprovada pelo criador do workspace.",
            image: "onboarding_image1",
            num: 0),
        
        OnboardingPage(
            title: "Documente sem\nperder tempo.",
            message: "Use os templates pra documentação de desenvolvimento, design ou gerência pra integrar o processo de forma fluida ao seu trabalho.",
            image: "onboarding_image1",
            num: 1),
        
        OnboardingPage(
            title: "Toda informação na\npalma da sua mão.",
            message: "Pesquise como quiser por todas as documentações feitas pelo time, seja de tasks antigas ou atuais.\n\nFicar alinhado nunca foi tão fácil.",
            image: "onboarding_image1",
            num: 2),
    ]
    
}

struct OnboardingView: View {
    
    @State private var pageIndex = 0
    let onboardingPages : [OnboardingPage] = OnboardingPage.samplePages
    
    var body: some View {
        
        TabView (selection: $pageIndex){
            ForEach(onboardingPages) { page in
                OnboardingPageView(onboardingPage: page, pageIndex: $pageIndex)
                    .tag(page.num)
            }
        }
    }

}

struct OnboardingPageView: View{
    
    var onboardingPage : OnboardingPage
    @Binding var pageIndex : Int
    @AppStorage("onboard") var isOnboard : Bool = false
    
    var body: some View{
        
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image("Ilustra_Novelo_GRANDE")
                        .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .opacity(0.3)
                }
            }
            
            VStack(alignment: .leading){
                Text(onboardingPage.title)
                    .font(.custom(SpaceGrotesk.bold.rawValue, size: 60))

                HStack{
                    VStack(alignment: .leading){
                        Text(onboardingPage.message)
                            .font(.custom(SpaceGrotesk.regular.rawValue, size: 20))
                        if onboardingPage.num == 0{
//                            Button("Próximo", action: incrementPage)
                            PopUpButton(text: "Próximo", onButtonTapped: incrementPage)
                        }
                        
                        if onboardingPage.num == 1{
                            HStack{
//                                Button("Voltar", action: decrementPage)
//                                Button("Próximo", action: incrementPage)
                                PopUpButton(text: "Voltar", onButtonTapped: decrementPage)
                                PopUpButton(text: "Próximo", onButtonTapped: incrementPage)
                            }
                        }
                        
                        if onboardingPage.num == 2{
                            HStack{
//                                Button("Voltar", action: decrementPage)
//                                Button("Começar"){
//                                    isOnboard = false
//                                }
                                PopUpButton(text: "Voltar", onButtonTapped: setOnboardingToFalse)
                                PopUpButton(text: "Começar", onButtonTapped: incrementPage)
                            }
                        }
                        Spacer()
                    }
                    .frame(maxWidth: 400, minHeight: 150, alignment: .leading)
                    Spacer()
                    Image(onboardingPage.image)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 600)
                        .layoutPriority(2)
                }
            }
            .padding(.top, 60)
            .padding(.leading, 30)
            .padding()
        }
        
    }
    
    func incrementPage(){
        self.pageIndex+=1
    }
    func decrementPage(){
        self.pageIndex-=1
    }
    func setOnboardingToFalse(){
        self.isOnboard = false
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
