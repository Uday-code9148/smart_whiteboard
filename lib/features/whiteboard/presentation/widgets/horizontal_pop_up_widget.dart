import 'package:flutter/material.dart';
import 'package:inboard_personal_project/core/wrappers/icon_with_list_wrapper.dart';

class HorizontalIconPopup extends StatelessWidget {
  final FeatureCategory feature;

  const HorizontalIconPopup({super.key, required this.feature});

  void _showCustomPopup(BuildContext context, GlobalKey key, List<FeatureCategory> items) {
    final RenderBox button = key.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final Offset position = button.localToGlobal(Offset.zero, ancestor: overlay);

    OverlayEntry? entry;

    entry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // ⛔ Tapping this will dismiss the popup
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              entry?.remove();
            },
            child: Container(color: Colors.transparent, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height),
          ),

          // ✅ Your actual popup
          Positioned(
            left: position.dx,
            top: position.dy - 80,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black12),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 6, offset: const Offset(0, 4))],
                ),
                height: 50,
                width: items.length * 45.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final itemKey = GlobalKey();
                    return Tooltip(
                      message: item.name,
                      child: IconButton(
                        key: itemKey,
                        icon: item.icon,
                        onPressed: item.items.isNotEmpty
                            ? () {
                                entry?.remove();
                                _showCustomPopup(context, itemKey, item.items);
                              }
                            : () {
                                entry?.remove();
                                item.onTap?.call();
                              },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(entry);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 4))],
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: feature.items.length,
        padding: EdgeInsets.all(15),
        separatorBuilder: (_, __) => const SizedBox(width: 15),
        itemBuilder: (context, index) {
          final item = feature.items[index];
          final itemKey = GlobalKey();

          return IconButton(
            key: itemKey,
            icon: item.icon,
            onPressed: item.items.isNotEmpty
                ? () {
                    _showCustomPopup(context, itemKey, item.items);
                  }
                : item.onTap,
          );
        },
      ),
    );
  }
}
