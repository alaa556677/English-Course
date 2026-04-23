import 'package:english/Features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';

class ItemActionsHelper {
  static void showEditSheet(
    BuildContext context, {
    required String docId,
    required String collection,
    required String currentContent,
    required String currentTranslate,
    required String contentLabel,
    required String contentFieldName,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _EditItemSheet(
        docId: docId,
        collection: collection,
        currentContent: currentContent,
        currentTranslate: currentTranslate,
        contentLabel: contentLabel,
        contentFieldName: contentFieldName,
      ),
    );
  }

  static void showDeleteDialog(
    BuildContext context, {
    required String docId,
    required String collection,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.delete_outline, color: Color(0xFFFF5252), size: 22),
            SizedBox(width: 8),
            Text(
              'Delete Item',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ],
        ),
        content: const Text(
          'Are you sure you want to delete this item? This action cannot be undone.',
          style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white54, fontWeight: FontWeight.w600),
            ),
          ),
          TextButton(
            onPressed: () {
              HomeCubit.instance.deleteDocument(collection, docId);
              Navigator.pop(ctx);
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFFF5252).withValues(alpha: 0.12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text(
              'Delete',
              style: TextStyle(
                color: Color(0xFFFF5252),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EditItemSheet extends StatefulWidget {
  final String docId;
  final String collection;
  final String currentContent;
  final String currentTranslate;
  final String contentLabel;
  final String contentFieldName;

  const _EditItemSheet({
    required this.docId,
    required this.collection,
    required this.currentContent,
    required this.currentTranslate,
    required this.contentLabel,
    required this.contentFieldName,
  });

  @override
  State<_EditItemSheet> createState() => _EditItemSheetState();
}

class _EditItemSheetState extends State<_EditItemSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _contentCtrl;
  late final TextEditingController _translateCtrl;

  @override
  void initState() {
    super.initState();
    _contentCtrl = TextEditingController(text: widget.currentContent);
    _translateCtrl = TextEditingController(text: widget.currentTranslate);
  }

  @override
  void dispose() {
    _contentCtrl.dispose();
    _translateCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      HomeCubit.instance.updateDocument(
        widget.collection,
        widget.docId,
        widget.contentFieldName,
        _contentCtrl.text.trim(),
        _translateCtrl.text.trim(),
      );
      Navigator.pop(context);
    }
  }

  Widget _buildField(
    TextEditingController ctrl,
    String label,
    String hint, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
              color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: ctrl,
          style: const TextStyle(color: Colors.white, fontSize: 15),
          maxLines: maxLines,
          minLines: 1,
          validator: (val) =>
              val == null || val.trim().isEmpty ? 'Required' : null,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.07),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: Colors.white.withValues(alpha: 0.20)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: Colors.white.withValues(alpha: 0.20)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: Color(0xFF4F8EF7), width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFFF5252)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: Color(0xFFFF5252), width: 1.5),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1A1A2E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4F8EF7),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Edit Item',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildField(
                _contentCtrl,
                widget.contentLabel,
                'Enter ${widget.contentFieldName}...',
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              _buildField(_translateCtrl, 'Translation', 'Enter translation...'),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F8EF7),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _submit,
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
