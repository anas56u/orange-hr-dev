import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';
import 'absence_type_list_item.dart';

class AbsenceTypeBottomSheet extends StatefulWidget {

  final String? currentSelection;

  const AbsenceTypeBottomSheet({super.key, this.currentSelection});

  @override
  State<AbsenceTypeBottomSheet> createState() => _AbsenceTypeBottomSheetState();
}

class _AbsenceTypeBottomSheetState extends State<AbsenceTypeBottomSheet> {

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

  bool _isSearching = false;
  late final TextEditingController _searchController;
  late List<String> _filteredTypes;

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

  void _clearAndCloseSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
      _filteredTypes = List.from(_absenceTypes);
    });
  }

  @override
  Widget build(BuildContext context) {

    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    final appColors = Theme.of(context).extension<AppColorsExtension>()!;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      decoration: BoxDecoration(
        color: appColors.cardBackground,
        borderRadius: _sheetRadius,
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

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
            Divider(height: 1, color: appColors.dividerColor),

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

            SizedBox(height: bottomPadding + 8),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultHeader() {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Select Type'.tr(),
          style: TextStyle(
            color: appColors.primaryText,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: Icon(Icons.search, color: appColors.primaryText, size: 24),
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

  Widget _buildSearchHeader() {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Row(
      children: [
        Icon(Icons.search, color: appColors.brandOrange, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            controller: _searchController,
            autofocus: true,
            onChanged: _onSearchChanged,
            style: TextStyle(fontSize: 16, color: appColors.primaryText),
            decoration: InputDecoration(
              hintText: 'Search absence type...',
              hintStyle: TextStyle(color: appColors.secondaryText, fontSize: 16),
              border: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.close, color: appColors.primaryText, size: 24),
          onPressed: _clearAndCloseSearch,
          tooltip: 'Close search',
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 48,
              color: appColors.secondaryText,
            ),
            const SizedBox(height: 12),
            Text(
              'No types found',
              style: TextStyle(
                color: appColors.secondaryText,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}