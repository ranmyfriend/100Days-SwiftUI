//
//  ContentView.swift
//  BucketList
//
//  Created by Ranjit on 20/10/20.
//

import SwiftUI

//Day-68
//1)Adding conformance to Comparable for custom types
//2)Writing data to the documents directory
//3)Switching view states with enums

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    //Here we are doing operator overloading
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct ContentView: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanaski"),
        User(firstName: "David", lastName: "Listener"),
    ].sorted()
//    sorted {
//        $0.lastName < $1.lastName
//    } //Straight away we cannot apply sorted into the array of users model. when we want to apply this kind of logic into array. it will be copy pasted.
    var body: some View {
        List(users, id:\.id) {
            Text($0.lastName + " " + $0.firstName)
        }
    }
}

struct ContentView2: View {
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    var body: some View {
        Text("Hello World").onTapGesture {
            let str = "Test Message"
            let url = self.getDocumentsDirectory().appendingPathComponent("message.txt")
            
            do {
                try str.write(to: url, atomically: true, encoding: .utf8)
                let input = try String(contentsOf: url)
                print(input)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed!")
    }
}

struct ContentView3: View {
    enum LoadingState {
        case loading, success, failed
    }
    
    var loadingState = LoadingState.loading
    
    var body: some View {
        
        Group {
            if loadingState == .loading {
                LoadingView()
            } else if loadingState == .success {
                SuccessView()
            } else if loadingState == .failed {
                FailedView()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
