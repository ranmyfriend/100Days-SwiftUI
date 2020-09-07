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
        TableInfo(question: "5 * 1 = ?", ans: 5, table: .oneX),
        TableInfo(question: "8 * 1 = ?", ans: 8, table: .oneX),
        
        TableInfo(question: "2 * 2 = ?", ans: 4, table: .twoX),
        TableInfo(question: "16 * 2 = ?", ans: 32, table: .twoX),
        
        TableInfo(question: "7 * 3 = ?", ans: 21, table: .threeX),
        TableInfo(question: "16 * 3 = ?", ans: 48, table: .threeX),
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
    
    var howManyRandomQuestions:Array<Int> = [1,5,10]
    @State private var maxRandomSelected = 1
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 20) {
                VStack {
                    Text("Currently '1' Random Question supported here.")
                        .foregroundColor(Color.red)
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .padding(.top, 20)
                        .padding(.bottom, 50)
                }
                
                VStack {
                    Text("How many Questions you want Ans?")                    .font(.system(size: 17, weight: .bold))
                    
                    Picker("", selection: $maxRandomSelected) {
                        ForEach(howManyRandomQuestions, id: \.self) { q in
                            Text(String(q))
                                .font(.system(size: 17))
                        }
                        }.pickerStyle(SegmentedPickerStyle())
                        .padding(20)
                    
                    HStack {
                        Spacer(minLength: 20)
                        Stepper("Select a Multiplication Table?\n Ex: \(selectedTable) * 1", value: $selectedTable, in: 1...12)
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                            .foregroundColor(Color.blue)
                        Spacer(minLength: 20)
                    }
                    
                    HStack {
                        Button(action: {
                            self.isUserInterested = true
                        }) {
                            Text("START GAME")
                                .padding(10)
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.blue)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
                        }
                    }
                    
                    
                    if self.isUserInterested {
                        HStack {
                            Text("Random Question: \(randomQuest.question)")
                                .font(.system(size: 21, weight: .bold, design: .rounded))
                                .foregroundColor(.red)
                                .padding([.leading], 20)
                                .background(Color.blue)
                            Spacer()
                        }
                        
                        HStack {
                            Spacer(minLength: 20)
                            TextField("Enter your ans", text: $answer, onCommit: {
                                let ans = Int(self.answer) ?? 0
                                let selectedTablee = Table(rawValue: self.selectedTable)!
                                self.isAnsCorrect = ContentView.tables.isAnsCorrect(quest: self.randomQuest.question, table: selectedTablee, ans: ans)
                            })
                                .font(.system(size: 21, weight: .heavy, design: .rounded))
                            Spacer(minLength: 20)
                        }
                    }
                    if self.isAnsCorrect {
                        Text(self.randomQuest.question + "\(answer) is Correct")
                            .foregroundColor(.green)
                            .font(.system(size: 21, weight: .heavy, design: .rounded))
                    }
                }
                Spacer()
            }
            .navigationBarTitle(Text("Day 35 Challenge Project"), displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
