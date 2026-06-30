/// Immutable domain entity representing a single sub-action
/// within a category (e.g. "Salary Slip" under "Payroll & Letters").
class CategoryActionItem {
  final String title;
  final String routeId;

  const CategoryActionItem({
    required this.title,
    required this.routeId,
  });
}
