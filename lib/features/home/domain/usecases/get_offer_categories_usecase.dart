import '../entities/offer_category.dart';
import '../repositories/offers_repository.dart';

class GetOfferCategoriesUseCase {
  final OffersRepository repository;

  const GetOfferCategoriesUseCase({required this.repository});

  List<OfferCategory> execute() {
    return repository.getOfferCategories();
  }
}