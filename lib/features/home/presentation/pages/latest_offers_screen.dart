import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/datasources/offers_local_data_source.dart';
import '../../data/repositories/offers_repository_impl.dart';
import '../../domain/usecases/get_offer_categories_usecase.dart';
import '../providers/latest_offers_provider.dart';
import '../widgets/latest_offers/offer_category_card.dart';
import '../widgets/latest_offers/offers_header.dart';

/// Dedicated screen for the "Latest Offers" category.
///
/// Displays a 2-column grid of offer sub-categories (Banks, Hotels, etc.)
/// each represented by an emoji illustration and a title, matching the
/// design image exactly.
///
/// Uses a scoped [ChangeNotifierProvider] that auto-disposes when
/// this screen is popped off the navigation stack — same lifecycle
/// pattern as [CategoryDetailScreen].
class LatestOffersScreen extends StatelessWidget {
  const LatestOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LatestOffersProvider>(
      create: (_) {
        final provider = LatestOffersProvider(
          useCase: GetOfferCategoriesUseCase(
            repository: OffersRepositoryImpl(
              dataSource: OffersLocalDataSource(),
            ),
          ),
        );
        // Load the categories immediately after creation.
        provider.loadCategories();
        return provider;
      },
      child: const _LatestOffersBody(),
    );
  }
}

/// The actual scaffold body — separated from [LatestOffersScreen] so that
/// [Consumer] can access the [LatestOffersProvider] from the ancestor
/// [ChangeNotifierProvider] created above.
class _LatestOffersBody extends StatelessWidget {
  const _LatestOffersBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Consumer<LatestOffersProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.orange),
              );
            }

            final categories = provider.categories;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Back button ---
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, top: 8.0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black87,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),

                // --- Header: tag icon + title ---
                const OffersHeader(),

                const SizedBox(height: 20),

                // --- Category grid ---
                // Uses GridView.builder for the same lazy-building /
                // widget-recycling semantics as ListView.builder,
                // adapted for the 2-column layout shown in the design.
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 8.0,
                    ),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 0.85,
                        ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return OfferCategoryCard(
                        category: category,
                        onTap: () {
                          
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
