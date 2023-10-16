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
        title: String(NSLocalizedString("Task concluída é\ntask documentada.", comment: "")),
        message: String(NSLocalizedString("Use o clássico kanban de um modo novo: toda task requer documentação para ser concluída, aprovada pelo criador do workspace.", comment: "")),
        image: "star",
        num: 0)
    
    static var samplePages : [OnboardingPage] =  [
        OnboardingPage(
            title: String(NSLocalizedString("Task concluída é\ntask documentada.", comment: "")),
            message: String(NSLocalizedString("Use o clássico **kanban** de um modo novo: toda task requer documentação para ser concluída, aprovada pelo **criador** do workspace.", comment: "")),
            image: "onboarding_image1",
            num: 0),
        
        OnboardingPage(
            title: String(NSLocalizedString("Documente sem\nperder tempo.", comment: "")),
            message: String(NSLocalizedString("Use os templates pra documentação de **desenvolvimento**, **design** ou **gerência** pra integrar o processo de forma fluida ao seu trabalho.", comment: "")),
            image: "onboarding_image2",
            num: 1),
        
        OnboardingPage(
            title: String(NSLocalizedString("Toda informação na\npalma da sua mão.", comment: "")),
            message: String(NSLocalizedString("Pesquise como quiser por todas as documentações feitas pelo time, seja de tasks antigas ou atuais.\n**Ficar alinhado nunca foi tão fácil.**", comment: "")),
            image: "onboarding_image3",
            num: 2),
    ]
    
}

struct OnboardingView: View {
    
    @State private var pageIndex = 0
    @Binding var isOnboarding: Bool
    let onboardingPages : [OnboardingPage] = OnboardingPage.samplePages
    
    init(isOnboarding: Binding<Bool>){
        self._isOnboarding = isOnboarding
    }
    var body: some View {
        ZStack {
            Image("onboarding_bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            TabView (selection: $pageIndex){
                ForEach(onboardingPages) { page in
                    OnboardingPageView(onboardingPage: page, pageIndex: $pageIndex, isOnboarding: $isOnboarding)
                        .tag(page.num)
                        .toolbar(.hidden)
                }
            }
        }
    }
    
}

struct OnboardingPageView: View{
    
    var onboardingPage : OnboardingPage
    @Binding var pageIndex : Int
    @Binding var isOnboarding: Bool
    
    var body: some View{
        VStack(alignment: .center){
                Text(onboardingPage.title)
                    .font(.custom(SpaceGrotesk.bold.rawValue, size: 80))
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                    .minimumScaleFactor(0.1)
                    .frame(maxWidth: 700, maxHeight: 200)
                    .multilineTextAlignment(.center)
                    VStack(alignment: .leading){
                        Image(onboardingPage.image)
                            .resizable()
                            .scaledToFit()
                            .ignoresSafeArea()
                            .layoutPriority(2)
                            .frame(maxWidth: 1000, maxHeight: 350)
                        BoldText(text: onboardingPage.message)
                            .padding(.leading, 50)
                            .multilineTextAlignment(.center)
                            .padding(.top, 50)
                        VStack(alignment: .center){
                            HStack(alignment: .center){
                                Spacer()
                                if onboardingPage.num == 0{
                                    PopUpButton(text: String(NSLocalizedString("Próximo",comment: "")), onButtonTapped: incrementPage)
                                        
                                    
                                }
                                
                                if onboardingPage.num == 1{
                                    Group{
                                        PopUpButton(text: String(NSLocalizedString("Voltar",comment: "")), onButtonTapped: decrementPage)
                                        PopUpButton(text: String(NSLocalizedString("Próximo",comment: "")), onButtonTapped: incrementPage)
                                    }
                                    
                                }
                                
                                if onboardingPage.num == 2{
                                    Group{
                                        PopUpButton(text: String(NSLocalizedString("Voltar",comment: "")), onButtonTapped: decrementPage)
                                        PopUpButton(text: String(NSLocalizedString("Começar",comment: "")), onButtonTapped: setOnboardingToFalse)
                                    }
                                    
                                }
                                Spacer()
                            }
                            .padding(.top, 50)
                            .padding(.bottom, 50)
                        }
                    }
                    .frame(maxWidth: 1050, minHeight: 150, alignment: .center)
            }
        }
    
    func incrementPage(){
        self.pageIndex+=1
    }
    func decrementPage(){
        self.pageIndex-=1
    }
    func setOnboardingToFalse(){
        self.isOnboarding = false
        UserDefaults.standard.set(false, forKey: "checkOnboarding")
    }
}
