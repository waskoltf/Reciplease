import SwiftUI
import Alamofire

class searchRecipeView :ObservableObject{
    @Published  var textInput: String = ""
    @Published  var ingredients: [String] = []
}



struct SearchView: View {
    
    @State private var OpenSheet = false
    @ObservedObject  var searchRecipe = SearchRecipe()
    @EnvironmentObject var searchRecipeView : searchRecipeView
    var body: some View {
        ZStack {
            Color(.brown)
                .ignoresSafeArea(.all)
            Image("Background-phone")
                .resizable()
                .ignoresSafeArea(.all)
  
            
            ScrollView {
                Spacer()
                Text("What's in your fridge?")
                    .foregroundColor(.black)
                    .font(.custom("American Typewriter", size: 25))
                
                HStack {
                    TextField("Lemon, cheese, sausages", text: $searchRecipeView.textInput)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        // Ajouter l'ingrédient à la liste
                        if !searchRecipeView.textInput.isEmpty {
                              searchRecipeView.ingredients.append(searchRecipeView.textInput)
                              searchRecipeView.textInput = "" // Effacer la saisie après l'ajout
                            OpenSheet = false
                          }
//                        searchRecipeView.ingredients.append(searchRecipeView.textInput)
//                        searchRecipeView.textInput = "" // Effacer la saisie après l'ajout
                    }) {
                        Text("Add")
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.green)
                            .cornerRadius(5)
                    }
                    .padding()
                }
                .background(Color("YellowSecondColor"))
                
                Spacer()
                
                HStack {
                    Text("Your ingredients: ")
                        .font(.custom("", size: 25))
                    
                    Spacer()
                    
                    Button(action: {
                        // Effacer la liste des ingrédients
                        searchRecipeView.ingredients.removeAll()
                    }) {
                        Text("Clear")
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.gray)
                            .cornerRadius(5)
                    }
                }
                .padding()
                
                Spacer()
                
                // Afficher les ingrédients dynamiquement
                VStack(alignment: .leading, spacing: 30) {
                    ForEach(searchRecipeView.ingredients, id: \.self) { ingredient in
                        HStack {
                            Text("- \(ingredient)")
                                .font(.custom("American Typewriter", size: 20))
                                .foregroundColor(.black)
                            Spacer()
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.3)
                .padding()
                .background(Color("YellowSecondColor"))
                .cornerRadius(15)
                
                Spacer()
                    .frame(height: UIScreen.main.bounds.height * 0.05)
                
                Button(action: {
                    // Action à effectuer lorsque le bouton est appuyé
                    // (Vous pouvez remplacer le commentaire par le code approprié)
                  
                        OpenSheet = true
                   


//                    let query = ingredients.joined(separator: ",")
//                    print(query)
//                                       searchRecipe.searchRecipes(query: query)
                    print("Search button tapped")
                }) {
                    Text("Search for recipe")
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.1)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.green)
                        .cornerRadius(5)
                }
                
//                Spacer()
//                 Ajout de la liste des recettes obtenues de l'API
//                ForEach(searchRecipe.recipes) { recipe in
//                    HStack {
//                        Text("- \(recipe.label)")
//                            .font(.custom("American Typewriter", size: 20))
//                            .foregroundColor(.black)
//                        Spacer()
//                    }
//                }
            }
            

        }
        .sheet(isPresented: $OpenSheet){
            ListRecipe()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

