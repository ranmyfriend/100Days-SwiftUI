//
//  AddBookView.swift
//  Day-54
//
//  Created by Ranjit on 03/10/20.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    @State private var showingAlert = false
    @State private var showingAlertMsg = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author of book", text: $author)
                }
                
                Picker("Genre", selection: $genre) {
                    ForEach(genres, id: \.self) {
                        Text($0)
                    }
                }
                
                Section {
                    //OLD CODE
//                    Picker("Rating", selection: $rating) {
//                        ForEach(0..<6) {
//                            Text("\($0)")
//                        }
//                    }
                    //NEW CODE - CUSTOM RATING VIEW
                    RatingView(rating: $rating)
                    
                    TextField("Write a review", text: $review)
                }
                
                Section {
                    Button("Save") {
                        if title.isEmpty || title.trimmingCharacters(in: .whitespaces).isEmpty {
                            showingAlertMsg = "Title is missing"
                            showingAlert = true
                        } else if author.isEmpty || author.trimmingCharacters(in: .whitespaces).isEmpty {
                            showingAlertMsg = "Author is missing"
                            showingAlert = true
                        }  else if genre.isEmpty || genre.trimmingCharacters(in: .whitespaces).isEmpty {
                            showingAlertMsg = "genre is missing"
                            showingAlert = true
                        } else {
                            let newBook = Book(context: self.moc)
                            newBook.title = title
                            newBook.author = author
                            newBook.genre = genre
                            newBook.rating = Int16(rating)
                            newBook.review = review
                            newBook.date = Date()
                            
                            try? self.moc.save()
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
            .navigationBarTitle("Add Book")
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Error"), message: Text(showingAlertMsg), dismissButton: .default(Text("OK")))
        }
    }
    
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
