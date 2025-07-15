import SwiftUI

struct RecipeCardView: View {
    var recipe: Recipe

    var body: some View {
            VStack(alignment: .leading) {
                //check if there is an image
                Image(recipe.images[0])
                    .resizable()
                    .scaledToFill()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
                
                Text(recipe.name)
                    .font(.headline)
                    .padding(.top, 5)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .multilineTextAlignment(.leading)
                
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        
    }
}

struct RecipeCardView_Previews:
    PreviewProvider {
    static var previews: some View {
        RecipeCardView(recipe: sampleRecipes[0])
    }
}

