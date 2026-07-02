import 'package:flutter/material.dart';
import 'absence_type_list_item.dart';

/// A modal bottom sheet that displays a selectable list of absence types with
/// interactive search functionality.
///
/// **Local State Management Decision:**
/// We manage transient search UI state ([_isSearching], [_searchController], and
/// [_filteredTypes]) locally within this [StatefulWidget] instead of polluting
/// [AbsenceProvider]. Since filtering the absence types list is a transient visual
/// concern specific to this modal bottom sheet and has no impact on global business
/// logic or form data until a type is actually chosen, keeping it scoped locally
/// adheres to clean architecture principles and prevents unnecessary provider rebuilds.
class AbsenceTypeBottomSheet extends StatefulWidget {
  /// The type that is already selected on the form, if any.
  final String? currentSelection;

  const AbsenceTypeBottomSheet({super.key, this.currentSelection});

  @override
  State<AbsenceTypeBottomSheet> createState() => _AbsenceTypeBottomSheetState();
}

class _AbsenceTypeBottomSheetState extends State<AbsenceTypeBottomSheet> {
  /// Absence types available for selection.
  static const List<String> _absenceTypes = [
    'Annual Leave',
    'Sick Leave',
    'Maternity Leave',
    'Paternity Leave',
    'Unpaid Leave',
    'Bereavement Leave',
    'Study Leave',
    'Type #1',
    'Type #2',
    'Type #3',
    'Type #4',
  ];

  // --- Transient Local Search State ---
  bool _isSearching = false;
  late final TextEditingController _searchController;
  late List<String> _filteredTypes;

  // --- Const style tokens ---
  static const _titleStyle = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const _handleWidth = 40.0;
  static const _handleHeight = 4.0;
  static const _handleColor = Color(0xFFBDBDBD);
  static const _sheetRadius = BorderRadius.vertical(top: Radius.circular(20));

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredTypes = List.from(_absenceTypes);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Filters [_filteredTypes] dynamically based on user input.
  void _onSearchChanged(String query) {
    final cleanQuery = query.trim().toLowerCase();
    setState(() {
      if (cleanQuery.isEmpty) {
        _filteredTypes = List.from(_absenceTypes);
      } else {
        _filteredTypes = _absenceTypes
            .where((type) => type.toLowerCase().contains(cleanQuery))
            .toList();
      }
    });
  }

  /// Clears the search field and resets the header to default state.
  void _clearAndCloseSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
      _filteredTypes = List.from(_absenceTypes);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine keyboard inset so the sheet adjusts smoothly when keyboard opens
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: _sheetRadius,
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- Drag handle ---
            const Padding(
              padding: EdgeInsets.only(top: 12.0, bottom: 8.0),
              child: Center(
                child: SizedBox(
                  width: _handleWidth,
                  height: _handleHeight,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: _handleColor,
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                  ),
                ),
              ),
            ),

            // --- Header with AnimatedCrossFade ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
              child: AnimatedCrossFade(
                firstChild: _buildDefaultHeader(),
                secondChild: _buildSearchHeader(),
                crossFadeState: _isSearching
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 250),
                alignment: Alignment.centerLeft,
              ),
            ),

            const SizedBox(height: 4),
            const Divider(height: 1, color: Color(0xFFEEEEEE)),

            // --- Types list or empty state ---
            Flexible(
              child: _filteredTypes.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: _filteredTypes.length,
                      itemBuilder: (context, index) {
                        final type = _filteredTypes[index];
                        return AbsenceTypeListItem(
                          title: type,
                          isSelected: type == widget.currentSelection,
                          onTap: () => Navigator.of(context).pop(type),
                        );
                      },
                    ),
            ),

            // Bottom safe-area spacing
            SizedBox(height: bottomPadding + 8),
          ],
        ),
      ),
    );
  }

  /// Builds the default header displaying the title and search icon button.
  Widget _buildDefaultHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Select Type', style: _titleStyle),
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black87, size: 24),
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
          tooltip: 'Search absence type',
        ),
      ],
    );
  }

  /// Builds the active search header with an autofocus TextField and close button.
  Widget _buildSearchHeader() {
    return Row(
      children: [
        const Icon(Icons.search, color: Colors.orange, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            controller: _searchController,
            autofocus: true,
            onChanged: _onSearchChanged,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
            decoration: const InputDecoration(
              hintText: 'Search absence type...',
              hintStyle: TextStyle(color: Color(0xFF9E9E9E), fontSize: 16),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: Colors.black87, size: 24),
          onPressed: _clearAndCloseSearch,
          tooltip: 'Close search',
        ),
      ],
    );
  }

  /// High-performance const empty state when no search results match.
  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 48.0, horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 48,
              color: Color(0xFFBDBDBD),
            ),
            SizedBox(height: 12),
            Text(
              'No types found',
              style: TextStyle(
                color: Color(0xFF757575),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
