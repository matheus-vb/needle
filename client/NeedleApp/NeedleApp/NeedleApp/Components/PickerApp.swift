//
//  Toogle.swift
//  NeedleApp
//
//  Created by vivi on 04/08/23.
//

import SwiftUI

struct OptionItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let color: Color
}

struct PickerApp: View {
    @State private var selectedOption: OptionItem
    var options: [OptionItem]
    
    init(selectedOption: OptionItem, options: [OptionItem]) {
        self._selectedOption = State(initialValue: selectedOption)
        self.options = options
    }
    
    
    var body: some View {
        VStack {
            Picker(selection: $selectedOption, label: Text("")) {
                ForEach(options) { option in
                    Text(option.title)
                        .background(Color("main-grey"))
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
        }
    }
}
