class Recipe {
    var name: String
    var images: [String]
    var rating: Double
    var description: String
    var ingredients: [IngredientGroup]
    var directions: [String]
    var notes: [String]
    var source: Source?
    // Time should be int and unit
    var prepTime: Double?
    var cookTime: Double?
    var servingSize: Int?
    var calories: Int?
    // add this
    var lastEditedDate: Int?

    init(
        name: String,
        images: [String] = [],
        rating: Double,
        description: String,
        ingredients: [IngredientGroup] = [],
        directions: [String] = [],
        notes: [String] = [],
        source: Source? = nil,
        prepTime: Double? = nil,
        cookTime: Double? = nil,
        servingSize: Int? = nil,
        calories: Int? = nil
    ) {
        self.name = name
        self.images = images
        self.rating = rating
        // limit size of these fields
        self.description = description
        self.ingredients = ingredients
        self.directions = directions
        self.notes = notes
        self.source = source
        self.prepTime = prepTime
        self.cookTime = cookTime
        self.servingSize = servingSize
        self.calories = calories
    }
}

// Sample static data
let sampleRecipes = [
    Recipe(
        name: "Kelly's Spaghetti Carbonara",
        images: ["spaghetti", "carbonara"],
        rating: 4.5,
        description:
            "A classic Italian pasta dish made with eggs, cheese, pancetta, and pepper.",
        ingredients: [
            IngredientGroup(
                heading: "Sauce",
                items: [
                    "1 15oz can Marazano tomatoes", "1tsp basil",
                    "1/2tsp salt",
                ]
            ),
            IngredientGroup(
                heading: "Grains",
                items: ["1 lb spaghetti", "1 tbsp olive oil", "1/2 cup grated parmesan", "2 large eggs", "1/4 cup pancetta or bacon", "1/2 tsp black pepper", "1 clove garlic", "1/4 cup parsley (optional)", "1/2 tsp red pepper flakes (optional)", "1/4 cup heavy cream (optional)", "1/2 cup peas (optional)", "1/4 cup mushrooms (optional)", "1/4 cup bell pepper (optional)", "1/4 cup onion (optional)" ]
            ),
        ],
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
        prepTime: 120,
        cookTime: 30,
        servingSize: 4,
        calories: 100
    ),
    Recipe(
        name: "Chicken Tikka Masala",
        images: ["tikka_masala.jpg"],
        rating: 4.7,
        description:
            "A popular Indian dish made with marinated chicken in a spiced curry sauce."
    ),
    Recipe(
        name: "Beef Stroganoff",
        images: ["stroganoff.jpg"],
        rating: 4.3,
        description:
            "A Russian dish of sautéed beef in a creamy mushroom sauce, served over noodles."
    ),
    Recipe(
        name: "Vegetable Stir Fry",
        images: ["stir_fry.jpg"],
        rating: 4.2,
        description:
            "A quick and healthy dish made with a variety of fresh vegetables stir-fried in a savory sauce."
    ),
    Recipe(
        name: "Chocolate Lava Cake",
        images: ["lava_cake.jpg"],
        rating: 4.8,
        description:
            "A rich chocolate cake with a gooey molten center, served warm with ice cream."
    ),
]
