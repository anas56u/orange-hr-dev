import '../entities/offer_category.dart';

/// Abstract repository contract for fetching offer categories.
///
/// The domain layer depends on this abstraction; the data layer
/// provides the concrete implementation ([OffersRepositoryImpl]).
abstract class OffersRepository {
  /// Returns all available offer categories to display on the grid.
  List<OfferCategory> getOfferCategories();
}
