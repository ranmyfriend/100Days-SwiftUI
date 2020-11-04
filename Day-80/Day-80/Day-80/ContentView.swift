//
//  ContentView.swift
//  Day-80
//
//  Created by Ranjit on 04/11/20.
//

import SwiftUI


//Day-80
//1)Understanding Swift’s Result type
//2)Manually publishing ObservableObject changes
//3)Controlling image interpolation in SwiftUI

enum NetworkError: Error {
    case badURL, requestFailed, unknown
}

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                fetchData(from: "https://www.apple.com") { result in
                    switch result {
                    case .success(let str):
                        print(str)
                    case .failure(let err):
                        switch err {
                        case .badURL:
                            print("Bad URL")
                        case .requestFailed:
                            print("Request failed")
                        case .unknown:
                            print("unknown")
                        }
                    }
                }
            }
    }
    
    func fetchData(from urlString: String, completion: @escaping (Result<String,NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            return completion(.failure(.badURL))
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    print("we got data")
                    let string = String(decoding: data, as: UTF8.self)
                    completion(.success(string))
                } else if let error = error {
                    print(error.localizedDescription)
                    completion(.failure(.requestFailed))
                } else {
                    completion(.failure(.unknown ))
                }
            }
        }.resume()
        
    }
}


class DelayedUpdater: ObservableObject {
//    @Published var value = 0 //If you removed @Published here UI wont reflect but the value will get added
    var value = 0 { //This is how we can manually send the notification without using @Published and here you can add or do some extra work on top of this. like lock the method, call something else.
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct ContentView_2: View {
    
    @ObservedObject var delayedUpdater = DelayedUpdater()
    
    var body: some View {
        Text("Value is:\(delayedUpdater.value)")
    }
}

struct ContentView_3: View {
    var body: some View {
        Image("example")
            .interpolation(.none) //SwiftUI gives us the interpolation() modifier that lets us control how pixel blending is applied
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
