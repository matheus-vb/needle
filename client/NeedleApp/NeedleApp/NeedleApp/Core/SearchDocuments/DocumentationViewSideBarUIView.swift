//
//  DocumentationViewSideBarUIView.swift
//  NeedleApp
//
//  Created by aaav on 06/10/23.
//

import SwiftUI

struct DocumentationViewSideBarUIView: View {
    @State private var overText = -1
    @State private var overText2 = -1

    @ViewBuilder
    func feedbackListCell(index: Int) -> some View{
        HStack{
            Image(systemName: "arrow.counterclockwise.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundColor(.orange)
                .background(.white)
                .clipShape(Circle())
                .padding(8)
            
            Text(NSLocalizedString("\(index)", comment: ""))
                .foregroundColor(Color.theme.blackMain)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 99)
    }
    @ViewBuilder
    func pendingListCell(index: Int) -> some View{
        
        VStack(alignment: .leading){
            
            HStack{
                Text(NSLocalizedString("\(index) e mais algo", comment: ""))
                    .font(.custom("SF Pro", size: 12))
                    .foregroundColor(Color.theme.blackMain)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "flag.fill")
                    .foregroundColor(.green)
            }
            HStack{
                Text(NSLocalizedString("\(index) e outro", comment: ""))
                    .font(.custom("SF Pro", size: 10))
                    .foregroundColor(Color.theme.blackMain)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Image(systemName: "square.fill")
                    .foregroundColor(.orange)
            }
        }
        .frame(height: 40)
    }
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(NSLocalizedString("Feedbacks", comment: ""))
                    .font(.custom("SF Pro", size: 18)
                        .weight(.bold))
                    .foregroundColor(Color.theme.blackMain)
                Spacer()
                Text(NSLocalizedString("Limpar", comment: ""))
                    .font(.custom("SF Pro", size: 14))
                    .foregroundColor(Color.theme.blackMain)
                    .opacity(0.6)
            }
            .padding(20)
            
            Spacer()
            
            VStack(alignment: .leading){
                HStack{
                    List{
                        ForEach(0..<10){i in
                            feedbackListCell(index: i)
                                .background(overText == i ? Color.theme.grayListHover : Color.clear)
                                .onHover{hovering in
                                    if hovering{
                                        overText = i
                                    } else {
                                        overText = -1
                                    }                                }
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))

                                .cornerRadius(9)
                        }
                    }
                    .frame( maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            Spacer()
            VStack(alignment: .leading){
                Text(NSLocalizedString("Documentação pendente", comment: ""))
                    .font(.custom("SF Pro", size: 18)
                        .weight(.bold))
                    .foregroundColor(Color.black)
                    .padding(20)
                
                HStack{
                    List{
                        ForEach(0..<10){i in
                            pendingListCell(index: i)
                                .background(overText2 == i ? Color.theme.grayListHover : Color.clear)
                                .onHover{hovering in
                                    if hovering{
                                        overText2 = i
                                    } else {
                                        overText2 = -1
                                    }
                                }
                                .cornerRadius(9)
                        }
                    }.scrollContentBackground(.hidden)
//                        .environment(\.defaultMinListRowHeight, 10)
                    
                }
            }
            Spacer()
        }
        .frame(width: 279)
        .frame(maxHeight: .infinity)
        .background(Color.theme.grayBackground)
    }
}



struct DocumentationViewSideBarUIView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentationViewSideBarUIView()
    }
}
