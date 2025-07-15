//
//  ImageCarousel.swift
//  biscuit_2
//
//  Created by kelly on 7/2/25.
//

import SwiftUI

struct ImageCarouselView: View {
    let images: [String]
    let editMode: Bool

    var body: some View {
        ZStack {
            TabView {
                ForEach(images, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 200, alignment: .top)
                        .clipped()
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 200)

//            if editMode {
//                Button(action: {
//                    // Add your action here
//                }) {
//                    Image("ellipses")
//                        .resizable()
//                        .renderingMode(.template)
//                        .foregroundColor(.white)
//                        .frame(width: 32, height: 32)
//                        .padding(.trailing, 20)
//                }
//                .frame(
//                    maxWidth: .infinity,
//                    maxHeight: .infinity,
//                    alignment: .topTrailing
//                )
//            }
        }

    }

}

struct ImageCarouselView_Previews:
    PreviewProvider
{
    static var previews: some View {
        ImageCarouselView(images: sampleRecipes[0].images, editMode: true)
    }
}
