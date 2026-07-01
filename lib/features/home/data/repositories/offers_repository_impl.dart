import '../../domain/entities/offer_category.dart';
import '../../domain/repositories/offers_repository.dart';
import '../datasources/offers_local_data_source.dart';

/// Concrete implementation of [OffersRepository].
///
/// Delegates to [OffersLocalDataSource] for data retrieval.
/// In the future, this could be swapped to fetch from an API
/// without touching the domain or presentation layers.
class OffersRepositoryImpl implements OffersRepository {
  final OffersLocalDataSource _dataSource;

  const OffersRepositoryImpl({required OffersLocalDataSource dataSource})
      // ignore: prefer_initializing_formals
      : _dataSource = dataSource;

  @override
  List<OfferCategory> getOfferCategories() {
    return _dataSource.getOfferCategories();
  }
}
