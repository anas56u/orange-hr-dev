import '../../domain/entities/offer_category.dart';
import '../../domain/repositories/offers_repository.dart';
import '../datasources/offers_local_data_source.dart';

class OffersRepositoryImpl implements OffersRepository {
  final OffersLocalDataSource _dataSource;

  const OffersRepositoryImpl({required OffersLocalDataSource dataSource})

      : _dataSource = dataSource;

  @override
  List<OfferCategory> getOfferCategories() {
    return _dataSource.getOfferCategories();
  }
}