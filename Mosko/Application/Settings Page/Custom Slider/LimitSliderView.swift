//
//  LimitSliderView.swift
//  mosko
//
//  Created by Deven Nathanael on 20/11/21.
//

import SwiftUI

struct LimitSliderView: View {
    @Binding var minValue: Double
    @Binding var maxValue: Double
    
    let allowed: ClosedRange<Double>
    
    let step: Double?
    
//    let onEditingChanged : ((Bool)->())?
    private let sliderHeight: CGFloat = 32
    private let barInset: CGFloat = 13
    
    var body: some View {
        HStack {
            Text(String(allowed.lowerBound))
            GeometryReader { geometry in
                ZStack {
                    HStack(spacing: 0) {
                        SliderBar(accented: false)
                            .frame(width: self.horizontalValue(for: minValue, given: geometry) + self.barInset)
                        SliderBar(accented: true)
                            .frame(width: self.horizontalValue(for: (self.allowed.lowerBound + self.maxValue - self.minValue), given: geometry))
                        SliderBar(accented: false)
                            .frame(width: self.horizontalValue(for: ( allowed.lowerBound + allowed.upperBound - self.maxValue), given: geometry)+self.barInset)
                    }
                    .padding([.leading,.trailing], -self.barInset)
                    // MARK: Min Value Handle
                    SliderHandle()
                        .position(CGPoint(x: self.horizontalValue(for: self.minValue, given: geometry), y: geometry.size.height/2))
                        .zIndex(1)
                        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                    .onChanged { value in
                            let position = value.location
                            let newValue = self.value(for: position, given: geometry)
                            self.minValue = min(newValue, self.maxValue)
                        })
                    // MARK: Max Value Handle
                    SliderHandle()
                        .position(CGPoint(x: self.horizontalValue(for: self.maxValue, given: geometry), y: geometry.size.height/2))
                        .zIndex(self.maxValue == self.allowed.upperBound ? 0 : 2)
                        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                    .onChanged { value in
                            let position = value.location
                            let newValue = self.value(for: position, given: geometry)
                            self.maxValue = max(newValue, self.minValue)
                        })
                }
            }
            .frame(height: 32)
            .padding([.horizontal], self.barInset)
            Text(String(allowed.upperBound))
        }
    }
    
    private func horizontalValue(for value: Double, given geometry:GeometryProxy) -> CGFloat {
        geometry.size.width * CGFloat((value - allowed.lowerBound)/(allowed.upperBound - allowed.lowerBound))
    }
    
    private func value(for position: CGPoint, given geometry: GeometryProxy) -> Double {
        var out = allowed.lowerBound + Double(position.x/geometry.size.width) * (allowed.upperBound - allowed.lowerBound)
        if let step = step {
            out = out - out.remainder(dividingBy: step)
        }
        return max(min(out, allowed.upperBound), allowed.lowerBound)
    }
}
fileprivate struct SliderBar: View {
    let accented: Bool
    private let defaultColor: Color = Color(UIColor(white: 0.9, alpha: 1))
    private var barColor : Color {
        accented ? .accentColor : defaultColor
    }
    
    var body: some View {
        Rectangle()
            .foregroundColor(barColor)
            .cornerRadius(2)
            .frame(height: 4)
    }
}
fileprivate struct SliderHandle: View {
    var body: some View {
        Circle()
            .foregroundColor(.white)
            .shadow(color: Color.black.opacity(0.2),radius: 2, x: 0, y: 1)
            .frame(width: 27, height: 27)
            .background(
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width:64, height: 64)
                    .contentShape(Rectangle())
            )
    }
}
struct LimitSliderView_Previews: PreviewProvider {
    @State static var minValue = 3.0

    @State static var maxValue = 6.0
    
    static var previews: some View {
        LimitSliderView(minValue: $minValue, maxValue: $maxValue, allowed: -0...10, step: nil)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}


