//
//  TabsView.swift
//  MultipleTabsSwiftUI
//
//  Created by Sarath kumar on 18/11/24.
//

import SwiftUI

struct TabsView: View {
    @State private var selectedTab: Tab?
    @Environment(\.colorScheme) private var colorScheme
    @State private var tabProgress: CGFloat = 0
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "line.3.horizontal.decrease")
                })
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "bell.badge")
                })
            }
            .font(.title2)
            .overlay {
                Text("Messages")
                    .font(.title3.bold())
            }
            .foregroundStyle(.primary)
            .padding(15)
            
            customTabs()
            
            GeometryReader {
                let size = $0.size
                
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 0) {
                        SampleScrollView(.purple)
                            .id(Tab.chats)
                            .containerRelativeFrame(.horizontal)
                        SampleScrollView(.green)
                            .id(Tab.calls)
                            .containerRelativeFrame(.horizontal)
                        SampleScrollView(.orange)
                            .id(Tab.settings)
                            .containerRelativeFrame(.horizontal)
                    }
                    .scrollTargetLayout()
                    .offsetX { value in
                        let progress = -value / (size.width * CGFloat(Tab.allCases.count - 1))
                        tabProgress = max(min(progress, 1), 0)
                    }
                    
                }
                .scrollPosition(id: $selectedTab)
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.paging)
                .scrollClipDisabled()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.gray.opacity(0.1))
        
    }
    
    @ViewBuilder
    func customTabs() -> some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                HStack(spacing: 10) {
                    Image(systemName: tab.systemImage)
                    Text(tab.rawValue)
                        .font(.callout)
                }
                .frame(maxWidth: .infinity)
                .padding(10)
                .contentShape(.capsule)
                .onTapGesture {
                    withAnimation(.snappy) {
                        selectedTab = tab
                    }
                }
            }
        }
        .tabMask(tabProgress)
        .background {
            GeometryReader {
                let size = $0.size
                let capsuleWidth = size.width / CGFloat(Tab.allCases.count)
                
                Capsule()
                    .fill(colorScheme == .dark ? .black : .white)
                    .frame(width: capsuleWidth)
                    .offset(x:tabProgress * (size.width - capsuleWidth))
            }
        }
        .background(.gray.opacity(0.1), in: .capsule)
        .padding(.horizontal, 15)
    }
    
    @ViewBuilder
    func SampleScrollView(_ color: Color) -> some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2), content: {
                ForEach(1...10, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 15)
                        .fill(color.gradient)
                        .frame(height: 150)
                        .overlay {
                            VStack(alignment: .leading) {
                                Circle()
                                    .fill(.white.opacity(0.4))
                                    .frame(width: 50, height: 50)
                                VStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(.white.opacity(0.4))
                                        .frame(width: 130, height: 8)
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(.white.opacity(0.4))
                                        .frame(width: 100, height: 8)
                                }
                                
                                Spacer()
                                
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.white.opacity(0.4))
                                    .frame(width: 80, height: 8)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding(15)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        
                }
                
            })
            .padding(15)
        }
        .scrollIndicators(.hidden)
        .scrollClipDisabled()
    }
}

#Preview {
    TabsView()
}
