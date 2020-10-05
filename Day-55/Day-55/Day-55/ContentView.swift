//
//  ContentView.swift
//  Day-55
//
//  Created by Ranjit on 05/10/20.
//

import SwiftUI
import CoreData

//Day 55
//This Project continues of Day 54
//1)Showing book details
//2)Sorting fetch requests with NSSortDescriptor
//3)Deleting from a Core Data fetch request
//4)Using an alert to pop a NavigationLink programmatically

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
