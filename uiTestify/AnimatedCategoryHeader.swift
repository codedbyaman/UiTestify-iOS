//
//  AnimatedCategoryHeader.swift
//  uiTestify
//
//  Created by Aman Kumar on 24/05/25.
//

import SwiftUI

struct AnimatedCategoryHeader: View {
    let title: String
    @State private var appear = false

    var body: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 24)
            .padding(.bottom, 4)
            .opacity(appear ? 1 : 0)
            .offset(y: appear ? 0 : 20)
            .onAppear { withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) { appear = true } }
    }
}
