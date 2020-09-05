//
//  ContentView.swift
//  Day-35-Challenge
//
//  Created by Ranjit on 05/09/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

//This is Day 35th Challenge Project. Its still Work in Progress.
//https://www.hackingwithswift.com/guide/ios-swiftui/3/3/challenge

enum Table: Int {
    case oneX = 1
    case twoX = 2
    case threeX = 3
    case fourX = 4
    case fiveX = 5
    case sixX = 6
    case sevenX = 7
    case eightX = 8
    case nineX = 9
    case tenX = 10
    case elevenX = 11
    case twleveX = 12
}

struct TableInfo {
    let question: String
    let ans: Int
    let table: Table
}

struct Tables {
    let info:[TableInfo] = [
        TableInfo(question: "5 ╳ 1 = ?", ans: 5, table: .oneX),
        TableInfo(question: "8 ╳ 1 = ?", ans: 8, table: .oneX),
        
        TableInfo(question: "2 ╳ 2 = ?", ans: 4, table: .twoX),
        TableInfo(question: "16 ╳ 2 = ?", ans: 32, table: .twoX),
        
        TableInfo(question: "7 ╳ 3 = ?", ans: 21, table: .threeX),
        TableInfo(question: "16 ╳ 3 = ?", ans: 48, table: .threeX),
    ]
    
    var presentTablesFound: [Table] {
        return [
            .oneX,
            .twoX,
            .threeX
        ]
    }
    
    func isAnsCorrect(quest: String, table: Table, ans: Int) -> Bool {
        !info.filter({$0.question == quest && $0.table == table && $0.ans == ans}).isEmpty
    }
    
    var randomQuestion: TableInfo? {
        info.randomElement()
    }
}

struct ContentView: View {
    @State private var selectedTable: Int = Table.oneX.rawValue
    @State private var isUserInterested: Bool = false
    static var tables = Tables()
    let randomQuest = tables.randomQuestion!
    @State private var answer: String = ""
    @State private var isAnsCorrect: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Currently 1 Random Question supported here.")
                .foregroundColor(Color.red)
                .font(.largeTitle)
                
                Stepper("Select a Multiplication Table you want?: \(selectedTable) ╳ 1", value: $selectedTable, in: 1...12)
                    .frame(height: 65)
                    .foregroundColor(Color.blue)
                Button("Enter") {
                    self.isUserInterested = true
                }
                .font(.largeTitle)
                .foregroundColor(.blue)
                if self.isUserInterested {
                    Text("Random Question: \(randomQuest.question)")
                    TextField("Enter your ans",text: $answer,onCommit: {
                        let ans = Int(self.answer) ?? 0
                        let selectedTablee = Table(rawValue: self.selectedTable)!
                        self.isAnsCorrect = ContentView.tables.isAnsCorrect(quest: self.randomQuest.question, table: selectedTablee, ans: ans)
                    })
                }
                if self.isAnsCorrect {
                    Text(self.randomQuest.question + "\(answer) is Correct").foregroundColor(.green).font(.largeTitle)
                }
            }
        .navigationBarTitle("Day 35 Challenge Project")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
