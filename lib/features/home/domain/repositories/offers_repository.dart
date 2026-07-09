import '../entities/offer_category.dart';

abstract class OffersRepository {

  List<OfferCategory> getOfferCategories();
}