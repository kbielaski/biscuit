//import UIKit
//
//class RecipeListViewController: UIViewController {
//    
//    private let recipeListView = RecipeListView()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//        populateRecipes()
//    }
//    
//    private func setupView() {
//        view.addSubview(recipeListView)
////        recipeListView.translatesAutoresizingMaskIntoConstraints = false
////        NSLayoutConstraint.activate([
////            recipeListView.topAnchor.constraint(equalTo: view.topAnchor),
////            recipeListView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
////            recipeListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
////            recipeListView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
////        ])
//    }
//    
//    private func populateRecipes() {
//        let recipes = [
//            Recipe(name: "Spaghetti Carbonara", image: "carbonara", rating: 4.5, description: "A classic Italian pasta dish made with eggs, cheese, pancetta, and pepper."),
//            Recipe(name: "Chicken Tikka Masala", image: "tikka_masala", rating: 4.7, description: "A popular Indian dish made with marinated chicken in a spiced curry sauce."),
//            Recipe(name: "Beef Stroganoff", image: "stroganoff", rating: 4.3, description: "A Russian dish of sautéed beef in a creamy mushroom sauce, served over noodles."),
//            Recipe(name: "Vegetable Stir Fry", image: "stir_fry", rating: 4.2, description: "A quick and healthy dish made with a variety of fresh vegetables stir-fried in a savory sauce."),
//            Recipe(name: "Chocolate Cake", image: "chocolate_cake", rating: 4.8, description: "A rich and moist chocolate cake topped with creamy chocolate frosting.")
//        ]
//        
//        recipeListView.recipes = recipes
//    }
//}
