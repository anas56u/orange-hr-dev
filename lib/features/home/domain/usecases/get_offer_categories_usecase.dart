import '../entities/offer_category.dart';
import '../repositories/offers_repository.dart';

/// Use case that retrieves all available offer categories.
///
/// Delegates to [OffersRepository] for data access, keeping the
/// presentation layer decoupled from the data layer.
class GetOfferCategoriesUseCase {
  final OffersRepository repository;

  const GetOfferCategoriesUseCase({required this.repository});

  /// Executes the use case and returns the list of [OfferCategory] items.
  List<OfferCategory> execute() {
    return repository.getOfferCategories();
  }
}
