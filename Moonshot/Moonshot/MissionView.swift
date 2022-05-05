//
//  MissionView.swift
//  Moonshot
//
//  Created by David Evans on 20/4/2022.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let astronauts: [String: Astronaut]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
//                        .accessibilityHidden(true)
                        .accessibilityLabel("The mission badge for \(mission.displayName)") // see solution where adds a description in the JSON!!

                    if let date = mission.launchDate {
                        Label(date.formatted(date: .complete, time: .omitted), systemImage: "calendar")
                            .padding(5)
                            .accessibilityHidden(true)
                    }

                    VStack(alignment: .leading) {

                        DividerView()
                        
                        Text("Mission Highlights")
                            .font(.title.bold())

                        Text("Launch date: \(mission.formattedLaunchDate)")
                            .font(.callout.bold())
                            .padding(.bottom, 5)

                        Text(mission.description)

                        DividerView()

                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)

                    CrewView(mission: mission, astronauts: astronauts)
                    
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.astronauts = astronauts
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String : Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[1], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
