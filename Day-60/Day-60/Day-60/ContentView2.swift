//
//  ContentView2.swift
//  Day-60
//
//  Created by Ranjit on 10/10/20.
//

import SwiftUI

struct ContentView2: View {
    @State private var isLoading: Bool = true
    @State private var personArray: [Person] = []
    @State private var filteredPersonArray: [Person] = []
    @State private var searchTxt = ""
    @State private var showActionSheet = false
    
    var personResults: [Person] {
        if !searchTxt.isEmpty && !searchTxt.trimmingCharacters(in: .whitespaces).isEmpty {
            return filteredPersonArray
        } else {
            return personArray
        }
    }
    
    var body: some View {
        #warning("when i add navigation view the activity indicator view is animation is not displaying correctly")
        //        NavigationView {
        ZStack {
            VStack {
                HStack {
                    TextField("Search Person", text: $searchTxt)
                        .onChange(of: searchTxt, perform: { value in
                            self.filteredPersonArray = personArray.filter({$0.name.contains(searchTxt)})
                        })
                        .padding()
                }
                List {
                    ForEach(personResults, id:\.id) { person in
                        VStack(alignment: .leading) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(person.name)
                                        .foregroundColor(Color.primary)
                                        .fontWeight(.black)
                                    Text(person.email)
                                        .underline()
                                        .foregroundColor(Color.blue).onTapGesture {
                                            self.showActionSheet = true
                                        }
                                }
                                Spacer()
                                Text(person.isActive ? "Active" : "Non-Active")
                                    .foregroundColor(person.isActive ? Color.blue : Color.red)
                            }
                            Text("\(person.friends.count) Friends")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            if isLoading {
                GeometryReader { geo in
                    ActivityIndicator()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .foregroundColor(Color.blue.opacity(0.60))
                }
            }
        }
        //            .navigationBarTitle("Challenge Project")
        //        }
        .onAppear(perform: loadFriendFaceJson)
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(title: Text("Email"), message: Text("How are you?"), buttons: [
                .default(
                    Text("SEND")
                        .foregroundColor(Color.blue)
                ),
                .destructive(Text("Cancel"))
            ])
        }
    }
    
    func loadFriendFaceJson() {
        self.isLoading = true
        URLSession.shared.personTask(with: URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!) { (personArray, response, error) in
            sleep(2) //explicit delay
            self.isLoading = false
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
