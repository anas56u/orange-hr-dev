import '../../domain/entities/offer_category.dart';

/// Local mock data source providing the list of offer categories.
///
/// Mirrors the pattern of [CategoryLocalDataSource]. The four categories
/// match the design: Banks, Resorts & Hotels, Nurseries/Schools/Universities,
/// and Restaurants & Cafes.
///
/// Emoji characters are used as illustrations because they render as
/// full-color platform-native graphics on both Android and iOS.
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

  /// Returns all offer categories from the local mock data.
  List<OfferCategory> getOfferCategories() {
    return _categories;
  }
}
