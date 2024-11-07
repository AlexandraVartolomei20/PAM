import '../../data/repositories/wine_repository.dart';
import '../entities/wine_entity.dart';

class GetWines {
  final WineRepository repository;

  GetWines(this.repository);

  Future<List<WineEntity>> execute() async {
    final wines = await repository.fetchWines();
    return wines.map((wine) => WineEntity(
      title: wine.title,
      price: wine.price,
      imagePath: wine.imagePath,
      availability: wine.availability,
      wineType: wine.wineType,
      origin: wine.origin,
      criticsScore: wine.criticsScore,
      bottleSize: wine.bottleSize,
    )).toList();
  }
}
