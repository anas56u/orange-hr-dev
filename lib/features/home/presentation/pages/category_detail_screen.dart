import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../data/datasources/category_local_data_source.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../domain/entities/action_category.dart';
import '../../domain/usecases/get_category_detail_usecase.dart';
import '../providers/category_detail_provider.dart';
import '../widgets/category_action_tile.dart';
import '../../../../features/absence/presentation/pages/absence_management_screen.dart';

/// Screen displaying the sub-actions for a given category.
///
/// Receives the [ActionCategory] from the home grid to ensure the
/// **exact same icon and color** are reused in the header — no
/// duplication of icon definitions across screens.
///
/// Uses a scoped [ChangeNotifierProvider] that auto-disposes when
/// this screen is popped off the navigation stack.
class CategoryDetailScreen extends StatelessWidget {
  /// The category whose sub-actions are to be displayed.
  /// This carries the exact icon + color from the HomeActionsGrid card.
  final ActionCategory category;

  const CategoryDetailScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    context.locale; // Subscribe to locale changes
    return ChangeNotifierProvider<CategoryDetailProvider>(
      create: (_) {
        final provider = CategoryDetailProvider(
          useCase: GetCategoryDetailUseCase(
            repository: CategoryRepositoryImpl(
              dataSource: CategoryLocalDataSource(),
            ),
          ),
        );
        // Load the sub-actions immediately after creation.
        provider.loadCategory(category.displayTitle);
        return provider;
      },
      child: _CategoryDetailBody(category: category),
    );
  }
}

class _CategoryDetailBody extends StatelessWidget {
  final ActionCategory category;

  const _CategoryDetailBody({required this.category});

  @override
  Widget build(BuildContext context) {
    context.locale; // Subscribe to locale changes
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<CategoryDetailProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.orange),
              );
            }

            final detail = provider.categoryDetail;
            final actions = detail?.actions ?? [];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Back button ---
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, top: 8.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black87),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),

                // --- Category header: icon + title ---
                // Reuses the EXACT same icon & color from the HomeActionsGrid card.
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 12.0,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        category.icon,
                        color: category.iconColor,
                        size: 32,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          context.tr(category.displayTitle),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 24.0),
                    itemCount: actions.length,
                    itemBuilder: (context, index) {
                      final action = actions[index];
                      return CategoryActionTile(
                        title: action.title,
                        onTap: () {
                          // Intercept "Absence Management" to navigate
                          // to the dedicated feature screen.
                          if (action.routeId == 'absence_management') {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    const AbsenceManagementScreen(),
                              ),
                            );
                            return;
                          }

                         
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
