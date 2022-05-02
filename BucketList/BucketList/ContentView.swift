//
//  ContentView.swift
//  BucketList
//
//  Created by David Evans on 2/5/2022.
//

import MapKit
import SwiftUI

enum LoadingState {
    case loading, success, failed
}

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
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
            Text("Failed.")
        }
    }

    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12),
                                                      span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))

    var body: some View {
        var loadingState: LoadingState = .loading
        let locations = [
            Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
            Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
        ]
        
        VStack {
            NavigationView {
                Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
    //                MapMarker(coordinate: location.coordinate)
                    MapAnnotation(coordinate: location.coordinate) {
//                        VStack {
                            NavigationLink {
                                Text(location.name)
                            } label: {
                                Circle()
                                    .stroke(.red, lineWidth: 3)
                                    .frame(width: 44, height: 44)
    //                                .onTapGesture {
    //                                    print("Tapped on \(location.name)")
    //                                }
    //                            Text(location.name)
                            }
//                        }
                    }
                }
            }
            navigationTitle("London Explorer")
            Text("Hello World")
                .onTapGesture {
                    let str = "Test Message"
                    let url = getDocumentsDirectory().appendingPathComponent("message.txt")
                    
                    do {
                        try str.write(to: url, atomically: true, encoding: .utf8)
                        let input = try String(contentsOf: url)
                        print(input)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            Group {
                switch loadingState {
                case .loading:
                    LoadingView()
                case .success:
                    SuccessView()
                case .failed:
                    FailedView()
                }
            }

        }
        
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
