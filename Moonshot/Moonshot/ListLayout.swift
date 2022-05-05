//
//  ListLayout.swift
//  Moonshot
//
//  Created by David Evans on 20/4/2022.
//

import SwiftUI

struct ListLayout: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        
        List(missions) { mission in
            NavigationLink {
                MissionView(mission: mission, astronauts: astronauts)
            } label: {
                HStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding()
                        .accessibilityHidden(true)
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.5))
                    }
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("\(mission.displayName) mission \(mission.launchDate != nil ? "launched on \(mission.formattedLaunchDate)" : "" ) ")
            }
            .listRowBackground(Color.darkBackground)
            
        }
        .listStyle(.plain)
    }
}

struct ListLayout_Previews: PreviewProvider {
    static let astronauts: [String : Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")

    static var previews: some View {
        Group {
            ListLayout(missions: missions, astronauts: astronauts)
                .preferredColorScheme(.dark)
        }
    }
}
