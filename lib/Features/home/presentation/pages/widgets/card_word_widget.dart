import 'package:flutter/material.dart';

class CardWordWidget extends StatelessWidget {
  final String englishText;
  final String arabicText;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CardWordWidget({
    super.key,
    required this.englishText,
    required this.arabicText,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final hasActions = onEdit != null || onDelete != null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: IntrinsicHeight(
          child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Green accent bar
            Container(width: 4, color: const Color(0xFF4CAF50)),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 14, 4, 14),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        englishText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 22,
                      color: Colors.white.withValues(alpha: 0.15),
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    Expanded(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          arabicText,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.75),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Actions menu
            if (hasActions)
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white.withValues(alpha: 0.45),
                  size: 20,
                ),
                color: const Color(0xFF1E1E3A),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                itemBuilder: (_) => [
                  if (onEdit != null)
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit_outlined,
                              color: Color(0xFF4F8EF7), size: 18),
                          SizedBox(width: 10),
                          Text('Edit',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                        ],
                      ),
                    ),
                  if (onDelete != null)
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete_outline,
                              color: Color(0xFFFF5252), size: 18),
                          SizedBox(width: 10),
                          Text('Delete',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                        ],
                      ),
                    ),
                ],
                onSelected: (val) {
                  if (val == 'edit') onEdit?.call();
                  if (val == 'delete') onDelete?.call();
                },
              ),
          ],
          ),
        ),
      ),
    );
  }
}
