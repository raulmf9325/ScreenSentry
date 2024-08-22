//
//  SegmentedControl.swift
//
//
//  Created by Raul Mena on 8/18/24.
//

import SwiftUI

public struct SegmentedControl: View {
    public init(selectedIndex: Binding<Int>, titles: [String]) {
        self._selectedIndex = selectedIndex
        self.titles = titles
    }

    @Binding var selectedIndex: Int
    let titles: [String]

    public var body: some View {
        let tabWidth = UIScreen.main.bounds.width / CGFloat(titles.count)
        VStack {
            HStack {
                HStack(spacing: 0) {
                    ForEach(0..<titles.count, id: \.self) { index in
                        HStack {
                            Button(action: {
                                selectedIndex = index
                            }) {
                                Text(titles[index])
                                    .font(.footnote)
                                    .fontWeight(.medium)
                                    .foregroundColor(selectedIndex == index ? .white : .gray)
                            }
                        }
                        .frame(width: tabWidth)
                    }
                }
            }
        }
        Capsule()
            .fill(Color.white)
            .frame(width: tabWidth)
            .offset(x: CGFloat(selectedIndex) * tabWidth)
            .animation(.easeInOut(duration: 0.3), value: selectedIndex)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 2)
            .background(
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
            )
    }
}

struct ContentView: View {
    @State private var selectedIndex = 0
    let titles = ["OVERVIEW", "BROWSE LOTS", "SEARCH"]

    var body: some View {
        VStack {
            SegmentedControl(selectedIndex: $selectedIndex, titles: titles)
                .padding(.top)

            Spacer()

            if selectedIndex == 0 {
                Text("Overview Content")
                    .foregroundStyle(.white)
            } else if selectedIndex == 1 {
                Text("Browse Lots Content")
                    .foregroundStyle(.white)
            } else if selectedIndex == 2 {
                Text("Search Content")
                    .foregroundStyle(.white)
            }

            Spacer()
        }
    }
}

#Preview {
    ContentView()
        .background(AppTheme.Colors.sectionViewColor)
}
