import SwiftUI
import CoreData

struct FavoriteView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FavoriteRecipe.id, ascending: true)],
        animation: .default
    ) private var favoriteRecipes: FetchedResults<FavoriteRecipe>

    @ObservedObject var viewModel = FavoriteViewModel() // Modification ici

    var body: some View {
        NavigationView {
            if favoriteRecipes.isEmpty {
                VStack {
                    Text("Your Favorites List is Empty")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding()

                    Text("Pour ajouter une recette à vos favoris, allez à l'écran des détails d'une recette et appuyez sur 'Ajouter aux favoris'.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .padding()
                }
            } else {
                List {
                    ForEach(favoriteRecipes) { favorite in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(favorite.label ?? "Unknown")
                                .font(.headline)

                            if let imageURL = URL(string: favorite.image ?? "") {
                                AsyncImage(url: imageURL) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    case .failure:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    @unknown default:
                                        fatalError()
                                    }
                                }
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                            }
                        }
                        .padding(8)
                        .background(Color("YellowSecondColor"))
                        .cornerRadius(8)
                    }
                    .onDelete { indexSet in
                            viewModel.deleteFavorite(offsets: indexSet)
                        }
                    
                }
                
                .navigationBarTitle("Favorites")
            }
        }
    }
}
