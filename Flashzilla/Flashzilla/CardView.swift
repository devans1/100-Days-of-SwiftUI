//
//  CardView.swift
//  Flashzilla
//
//  Created by David Evans on 16/5/2022.
//

import SwiftUI

struct CardView: View {
    let card: Card
    var removal: ((_ reTry: Bool) -> Void)? = nil    // ***** because this is declared after the card, it gets to be a "trailing closure" and observes trailing closure syntax!!!!!!
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    @State private var feedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                    ? .white
                    : .white.opacity(1 - Double(abs(offset.width / 50)))
                )
                .cardStyle(offset: offset,
                           differentiateWithoutColor: differentiateWithoutColor)
//                .background(
//                    differentiateWithoutColor
//                    ? nil
//                    : RoundedRectangle(cornerRadius: 25, style: .continuous)
//                        .fill(offset.width > 0 ? .green : .red)
//                )
                .shadow(radius: 10)
            
            VStack {
                if voiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged({ gesture in
                    offset = gesture.translation
                    feedback.prepare()
                })
                .onEnded({ _ in
                    if abs(offset.width) > 100 {
                        // remove the card
                        // haptics
                        if offset.width < 0 {
//                            feedback.notificationOccurred(.success) // you can overdo haptics so remove this one
//                        } else {
                            feedback.notificationOccurred(.error)
                        }
                        
                        removal?(offset.width < 0)
                        if offset.width < 0 {
                            offset = .zero
                        }
                    } else {
                        offset = .zero
                    }
                })
        )
        .onTapGesture(perform: {
            isShowingAnswer.toggle()
        })
        .animation(.spring(), value: offset)
        
    }
}

struct CardBG: ViewModifier {
    let offset: CGSize
    let differentiateWithoutColor: Bool
    
    var col : Color {
        get {
            if offset.width > 0 {
                return .green
            } else if offset.width < 0 {
                return .red
            }
            return .white
        }
    }
    
    func body(content: Content) -> some View {
        if differentiateWithoutColor {
            content
        } else {
            content
                .background(
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(col)
                )
        }
    }
}

extension View {
    func cardStyle(offset: CGSize, differentiateWithoutColor: Bool) -> some View {
        modifier(CardBG(offset: offset, differentiateWithoutColor: differentiateWithoutColor))
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
