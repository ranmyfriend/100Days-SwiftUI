//
//  ContentView.swift
//  Day-49
//
//  Created by Ranjit on 27/09/20.
//

import SwiftUI

//Day - 49 - Part one
//Cupcake Corner Project

//Adding Codable conformance for @Published properties

/* Notes:
 By default when you are confirming the ObservableObject protocol and codable Swift gives us error.
 It because swift tells us to write encode & decode methods to archive and unarchive properties which are belongs to marking them as Published
 */
class User: ObservableObject, Codable {
    @Published var name: String = "Steve Jobs"
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

//Sending and receiving Codable data with URLSession and SwiftUI
//Here we are going to call iTunesApi to get back the Taylor swift tracks
struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    @State private var results = [Result]()
    var body: some View {
        List(results, id:\.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                
                Text(item.collectionName)
            }
        }.onAppear(perform: loadData)
    }
    
    func loadData() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            return print("Invalid URL")
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                if let decodeResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        self.results = decodeResponse.results
                    }
                }
            }
        }.resume()
        
    }
}

//Validating and disabling forms

struct FormView: View {
    @State private var name = ""
    @State private var email = ""
    
    var disableForm: Bool {
        name.count > 5 || email.count < 5
    }
    var body: some View {
        Form {
            Section {
                TextField("UserName", text: $name)
                TextField("Email", text: $email)
            }
            Section {
                Button("Create Account") {
                    print("Creating account...")
                }
            }
            //This can be disable the entire form.
            .disabled(disableForm)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
