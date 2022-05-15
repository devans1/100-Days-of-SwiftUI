//
//  ProspectsView.swift
//  HotProspects1
//
//  Created by David Evans on 12/5/2022.
//

import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    enum SortByType: String, CaseIterable, Identifiable {
        case date = "Date"
        case name = "Name"
        var id: Self { self }
    }

    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var isShowingSortDialog = false
    
    let filter: FilterType
    @Binding var sortOrder: SortByType

    var body: some View {
        NavigationView {
            List {
                ForEach(sortedProspects) { prospect in
                    HStack(alignment: .center) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(prospect.name)
                                    .font(.headline)
                                Text(prospect.dateAdded.formatted())
                                    .foregroundColor(.secondary)
                            }
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        // Could do better  - only put in Everyone view and just make it a check mark "checkmark.circle.fill"
                        Image(systemName: prospect.isContacted ? "person.crop.circle.fill.badge.checkmark" : "person.crop.circle.badge.xmark")

                    }
                    .swipeActions {
                        if prospect.isContacted {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                            
                            Button {
                                addNotification(for: prospect)
                            } label: {
                                Label("Remind Me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                // BETTER add a ToolbarItem and then you can adda  placement
                ToolbarItemGroup(placement: .navigationBarTrailing)  {
                    Button(role: nil,
                           action: {
                        isShowingScanner = true
                    },
                           label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    })
                    Picker(selection: $sortOrder,
                           content: {
                        ForEach(SortByType.allCases) {
                            Text($0.rawValue)
                        }
                    }, label: {
                        Image(systemName: "arrow.up.arrow.down.square")
                    })
//                    Picker("Sort" ,
//                           selection: $sortOrder) {
//                        ForEach(SortByType.allCases) {
//                            Text($0.rawValue)
//                        }
//                    }
                    .pickerStyle(.segmented)
                    
//                    Button(role: nil,
//                           action: {
//                        isShowingSortDialog = true
//                    },
//                           label: {
//                        Label("Sort", systemImage: "arrow.up.arrow.down.square")
//                    })
//                      BETTER?? Paul's solution was a confirmationDialog
//                    .confirmationDialog("Sort by…", isPresented: $isShowingSortOptions) {
//                        Button("Name (A-Z)") { sortOrder = .name }
//                        Button("Date (Newest first)") { sortOrder = .date }
//                    }
                }
            }
            .sheet(isPresented: $isShowingScanner,
                   content: {
                CodeScannerView(codeTypes: [.qr],
//                                scanMode: <#T##ScanMode#>,
//                                scanInterval: <#T##Double#>,
//                                showViewfinder: <#T##Bool#>,
                                simulatedData: "Paul Hudson\npaul@hackingwithswift.com",
//                                shouldVibrateOnSuccess: <#T##Bool#>,
//                                isTorchOn: <#T##Bool#>,
//                                isGalleryPresented: <#T##Binding<Bool>#>,
//                                videoCaptureDevice: <#T##AVCaptureDevice?#>,
                                completion: handleScan)
            })
            .sheet(isPresented: $isShowingSortDialog,
                   content: {
                Text("Sort by name")
                .onTapGesture(perform: {
                    sortOrder = .name
                })
                Text("Sort by date")
                .onTapGesture(perform: {
                    sortOrder = .date
                })

            })
        }
        
    }
    
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects : [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter({ $0.isContacted })
        case .uncontacted:
            return prospects.people.filter({ !$0.isContacted })
        }
    }
    
    var sortedProspects: [Prospect] {
        switch sortOrder {
        case .date:
            return filteredProspects.sorted(by: {
                Prospect.sortByDate(lhs: $0, rhs: $1)
            })
        case .name:
            return filteredProspects.sorted(by: {
                Prospect.sortByName(lhs: $0, rhs: $1)
            })
        }
    }
    
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }

            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]

            prospects.add(person)
            
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }

    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

            var dateComponents = DateComponents()
            dateComponents.hour = 9
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) // for testing purposes trigger 5 seconds from now

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }
    
}

struct ProspectsView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProspectsView(filter: .none, sortOrder: .constant(.name))
            .environmentObject(Prospects())
    }
}
