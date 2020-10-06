//
//  ContentView.swift
//  Day-56
//
//  Created by Ranjit on 06/10/20.
//

import SwiftUI
import CoreData

//Day-56
//Challenge Project
//1.Right now it’s possible to select no genre for books, which causes a problem for the detail view. Please fix this, either by forcing a default, validating the form, or showing a default picture for unknown genres – you can choose.
//2.Modify ContentView so that books rated as 1 star have their name shown in red.
//3.Add a new “date” attribute to the Book entity, assigning Date() to it so it gets the current date and time, then format that nicely somewhere in DetailView.

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddBookScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(
                        destination: DetailView(book: book)) {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown Title")
                                .font(.headline)
                                .foregroundColor(book.rating > 1 ? Color.black : Color.red)
                            Text(book.author ?? "Unknown Author")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showingAddBookScreen = true
            }, label: {
                Image(systemName: "plus")
            }))
            .navigationBarTitle("Bookworm")
            .sheet(isPresented: $showingAddBookScreen) {
                AddBookView().environment(\.managedObjectContext, self.moc)
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        
        try? moc.save()
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
