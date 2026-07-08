import '../entities/category_detail.dart';
import '../repositories/category_repository.dart';

/// Use case that retrieves the detail (sub-actions) for a given category.
///
/// Takes the category's display title and returns a [CategoryDetail]
/// if sub-actions are defined, or `null` for categories without data yet.
class GetCategoryDetailUseCase {
  final CategoryRepository repository;

  const GetCategoryDetailUseCase({required this.repository});

  CategoryDetail? execute(String categoryTitle) {
    return repository.getCategoryDetail(categoryTitle);
  }
}
I want you to act as a senior Flutter architect and debugger.

Do NOT modify any code.
Do NOT suggest code changes.
Do NOT implement any solution yet.

Your only task is to analyze and understand the root cause of the following issue.

Project stack:
- Flutter
- easy_localization
- Provider
- Clean Architecture

Issue:
When changing the app language using easy_localization, only the currently visible screen updates immediately.

Some previous screens, AppBars, and widgets that were already pushed into the Navigator stack keep displaying the old language until a Hot Reload is performed.

As an experiment, adding:

key: ValueKey(context.locale)

to MaterialApp fixes the problem because it recreates the entire MaterialApp and Navigator, causing every screen to rebuild.

However, this also destroys the navigation stack and restarts the app from Splash/Login, which proves that rebuilding the entire application is not the desired solution.

Your task is NOT to fix this.

Instead, investigate and explain:

1. Why does this behavior happen?
2. How does easy_localization propagate locale changes internally?
3. How does Flutter decide which widgets rebuild when the locale changes?
4. Why do some screens rebuild while others don't?
5. What role does Navigator play in this behavior?
6. Could cached routes or inactive routes prevent rebuilding?
7. Could const widgets be involved?
8. Could Provider, BuildContext, InheritedWidget, or widget lifecycle be involved?
9. Is this expected Flutter behavior or a bug in the project architecture?
10. What is the most likely root cause based on Flutter's architecture?

Do not assume anything without evidence.

First, analyze the project architecture and identify the root cause.

Only after identifying the exact cause should we discuss possible solutions in a later step.

At this stage, I only want the diagnosis and architectural explanation, not the fix.