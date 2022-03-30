//
//  PlaceImageView.swift
//  Five
//
//  Created by Goga Eusebiu on 30.03.2022.
//

import SwiftUI

struct PlaceImageView: View {
    @ObservedObject var placeImageViewModel: PlaceImageViewModel
    
    var placeFsqId: String?
    
    init(_ placeFsqId: String?) {
        self.placeFsqId = placeFsqId
        self.placeImageViewModel = PlaceImageViewModel(self.placeFsqId)
    }

    var body: some View {
        ZStack {
            if let image = placeImageViewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 400)
            } else if placeImageViewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.gray)
            }
        }
    }
}
