import SwiftUI

struct RecipeListView: View {
    let recipes = [
        Recipe(
            name: "Kelly's Spaghetti Carbonara Long Title",
            images: ["spaghetti", "carbonara"],
            isBookmarked: false,
            description:
                "A classic Italian pasta dish made with eggs, cheese, pancetta, and pepper.",
            ingredients: ObservableArray<IngredientGroup>(array: [
                IngredientGroup(
                    heading: "Sauce",
                    items: [
                        "1 15oz can Marazano tomatoes", "1tsp basil",
                        "1/2tsp salt",
                    ]
                ),
                IngredientGroup(
                    heading: "Grains",
                    items: ["1 lb spaghetti", "1 tbsp olive oil", "1/2 cup grated parmesan", "2 large eggs", "1/4 cup pancetta or bacon", "1/2 tsp black pepper", "1 clove garlic", "1/4 cup parsley (optional)", "1/2 tsp red pepper flakes (optional)", "1/4 cup heavy cream (optional)", "1/2 cup peas (optional)", "1/4 cup mushrooms (optional)", "1/4 cup bell pepper (optional)", "1/4 cup onion (optional)"]
                ),
            ]),
            directions: [
                "Cook spaghetti in boiling water",
                "In a separate pan, cook pancetta until crispy",
                "Whisk eggs and cheese together",
                "Combine spaghetti with pancetta and egg mixture",
                "Serve with extra cheese and pepper",
            ],
            notes: [
                "Kids love this!",
                "Substitute pancetta with bacon for a different flavor.",
                "Carbs: 100g, Protein: 10g, Fat: 5g",
            ],
            source: Source(
                author: "Kelly Smith",
                url: "https://example.com/recipe/carbonara"
            ),
            prepTime: 60,
            cookTime: 30,
            servingSize: 4,
            calories: 100

        ),
        Recipe(
            name: "Chicken Tikka Masala",
            images: ["chicken_tikka"],
            isBookmarked: false,
            description:
                "A popular Indian dish consisting of marinated chicken in a spiced curry sauce."
        ),
        Recipe(
            name: "Beef Tacos",
            images: ["beef_tacos"],
            isBookmarked: false,
            description:
                "Soft or hard shell tacos filled with seasoned beef, lettuce, cheese, and salsa."
        ),
        Recipe(
            name: "Caesar Salad",
            images: ["caesar_salad"],
            isBookmarked: false,
            description:
                "A fresh salad with romaine lettuce, croutons, parmesan cheese, and Caesar dressing."
        ),
        Recipe(
            name: "Chocolate Cake",
            images: ["chocolate_cake"],
            isBookmarked: false,
            description:
                "A rich and moist chocolate cake topped with creamy chocolate frosting."
        ),
    ]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        NavigationView {
            List(recipes, id: \.name) { recipe in
                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                    RecipeCardView(recipe: recipe)
                }
            }
        }

        //        ScrollView {
        //            LazyVGrid(columns: columns, spacing: 16) {
        //                ForEach(recipes, id: \.name) { recipe in
        //                    RecipeCardView(recipe: recipe)
        //                }
        //            }
        //            .padding()
        //
        //        }
        //
        //        .navigationTitle("Recipes")
    }
}

struct RecipeListView_Previews:
    PreviewProvider
{
    static var previews: some View {
        RecipeListView()
    }
}
