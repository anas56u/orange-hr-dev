import '../../domain/entities/offer_category.dart';

class OffersLocalDataSource {
  static const List<OfferCategory> _categories = [
    OfferCategory(
      title: 'Banks',
      emoji: '🏦',
    ),
    OfferCategory(
      title: 'Resorts\n& Hotels',
      emoji: '🏨',
    ),
    OfferCategory(
      title: 'Nurseries, Schools\n& Universities',
      emoji: '🎓',
    ),
    OfferCategory(
      title: 'Restaurants\n& Cafes',
      emoji: '🍽️',
    ),
  ];

  List<OfferCategory> getOfferCategories() {
    return _categories;
  }
}