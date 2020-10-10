//
//  ContentView2.swift
//  Day-60
//
//  Created by Ranjit on 10/10/20.
//

import SwiftUI

struct ContentView2: View {
   @State var personArray: [Person] = []
    var body: some View {
        NavigationView {
            List {
                ForEach(personArray, id:\.id) { person in
                    VStack(alignment: .leading) {
                        Text(person.name)
                            .foregroundColor(.primary)
                        Text("\(person.friends.count) Friends")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationBarTitle("Challenge Project")
        }.onAppear(perform: loadFriendFaceJson)
    }
    
    func loadFriendFaceJson() {
        URLSession.shared.personTask(with: URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!) { (personArray, response, error) in
            if let pArray = personArray {
                self.personArray = pArray
            } else if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("Network problem")
            }
        }.resume()
    }
}


struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping ([T]?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode([T].self, from: data), response, nil)
        }
    }

    func personTask(with url: URL, completionHandler: @escaping ([Person]?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
