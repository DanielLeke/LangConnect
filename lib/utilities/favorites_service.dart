import 'package:langconnect/utilities/users_service.dart';

class FavoritesService {
  Future<void> addToFavorites(String email, String newFavorite) async {
    List<String> favorites = [];
    favorites.add(newFavorite);
    UsersService _usersService = UsersService();
    await _usersService.addInfo(
        email: email, field: "favorites", info: favorites);
  }

  Future<List<String>> getFavorites(String email) async {
    UsersService _usersService = UsersService();
    String favorites = await _usersService.getUserInformation(
        email: email, field: "favorites");
    return favorites.split(",");
  }

  Future<void> removeFromFavorites(String email, String favorite) async {
    List<String> favorites = await getFavorites(email);
    favorites.remove(favorite);
    UsersService _usersService = UsersService();
    await _usersService.addInfo(
        email: email, field: "favorites", info: favorites);
  }
}
