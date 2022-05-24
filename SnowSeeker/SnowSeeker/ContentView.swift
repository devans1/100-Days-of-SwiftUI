//
//  ContentView.swift
//  SnowSeeker
//
//  Created by David Evans on 23/5/2022.
//

import SwiftUI

// to get around the landscape view on iPhone Pro Max, can use this but not being
extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView: View {
    let resorts : [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var searchText = ""
    
    @StateObject var favorites = Favorites()
    
    @State private var sortingAttribute: Resort.SortBy = .none
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )

                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Label("Change sort order", systemImage: "arrow.up.arrow.down")
                        .foregroundColor(Color.accentColor)
                        .font(.subheadline)
//                    Text("Sort:")
//                        .foregroundColor(Color.accentColor)
//                        .font(.subheadline)
                    Picker("Sort", selection: $sortingAttribute) {
                        ForEach(Resort.SortBy.allCases, id: \.self) { name in
                            Text(name.rawValue)
                                .font(.subheadline)
                        }
                    }
//                    .pickerStyle(.segmented)
                }
            }

            
            // Everything above is primary view, everything below is secondary view
            WelcomeView()
        }
        .environmentObject(favorites)
//        .phoneOnlyStackNavigationView() Paul's choice to remove
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
                .sorted(by: Resort.sortBy(resortAttribute: sortingAttribute))
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
                .sorted(by: Resort.sortBy(resortAttribute: sortingAttribute))
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
