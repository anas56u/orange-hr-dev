/// Immutable domain entity representing a category of corporate offers
/// (e.g. Banks, Restaurants & Cafes, Resorts & Hotels).
///
/// Each category is displayed as a tappable card on the [LatestOffersScreen]
/// grid, with an emoji illustration and a centered title.
class OfferCategory {
  /// Display title shown beneath the emoji illustration.
  final String title;

  /// Emoji character used as the visual illustration for this category.
  /// Renders as a full-color graphic on mobile platforms.
  final String emoji;

  const OfferCategory({
    required this.title,
    required this.emoji,
  });
}
