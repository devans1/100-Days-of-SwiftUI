//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by David Evans on 4/5/2022.
//

import SwiftUI


extension EditView {

    @MainActor class EditViewModel: ObservableObject {
        
        enum LoadingState {
            case loading, loaded, failed
        }

        @Published var name: String
        @Published var description: String
        
        @Published var loadingState = LoadingState.loading
        @Published var pages = [Page]()

        var location: Location
        
        init(location: Location) {
            self.location = location

            name = location.name
            description = location.description
        }

        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            
            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                // we got some data back!
                let items = try JSONDecoder().decode(Result.self, from: data)
                
                // success – convert the array values to our pages array
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
            } catch {
                // if we're still here it means the request failed somehow
                loadingState = .failed
            }
        }

    }
}


/*
 
var components = URLComponents()
components.scheme = "https"
components.host = "en.wikipedia.org"
components.path = "/w/api.php"
components.queryItems = [
    URLQueryItem(name: "ggscoord", value: "\(placemark.coordinate.latitude)|\(placemark.coordinate.longitude)"),
    URLQueryItem(name: "action", value: "query"),
    URLQueryItem(name: "prop", value: "coordinates|pageimages|pageterms"),
    URLQueryItem(name: "colimit", value: "50"),
    URLQueryItem(name: "piprop", value: "thumbnail"),
    URLQueryItem(name: "pithumbsize", value: "500"),
    URLQueryItem(name: "pilimit", value: "50"),
    URLQueryItem(name: "wbptterms", value: "description"),
    URLQueryItem(name: "generator", value: "geosearch"),
    URLQueryItem(name: "ggsradius", value: "10000"),
    URLQueryItem(name: "ggslimit", value: "50"),
    URLQueryItem(name: "format", value: "json")
]
print(components.url ?? "Bad URL.")

*/
