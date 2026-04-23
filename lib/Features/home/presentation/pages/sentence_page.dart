import 'package:english/Features/home/presentation/cubit/home_cubit.dart';
import 'package:english/Features/home/presentation/cubit/home_states.dart';
import 'package:english/Features/home/presentation/pages/widgets/card_sentence_widget.dart';
import 'package:english/core/shared/item_actions_helper.dart';
import 'package:english/core/styles/colors.dart';
import 'package:english/core/widgets/default_no_data_found.dart';
import 'package:english/core/widgets/default_search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SentencePage extends StatefulWidget {
  const SentencePage({super.key});
  @override
  State<SentencePage> createState() => _SentencePageState();
}

class _SentencePageState extends State<SentencePage> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    HomeCubit.instance.getSentencesOnline();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = HomeCubit.instance;

        if (cubit.isLoadingSentences) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.accent),
          );
        }

        if (cubit.hasErrorSentences) {
          return _ErrorView(onRetry: cubit.getSentencesOnline);
        }

        if (cubit.sentencesDataOnlineList.isEmpty) {
          return const NotFoundPage(label: 'No Sentences Yet');
        }

        final isSearching = _searchCtrl.text.isNotEmpty;
        final list = isSearching
            ? cubit.searchSentenceListOnline
            : cubit.sentencesDataOnlineList;

        return Column(
          children: [
            SearchTextForm(
              searchController: _searchCtrl,
              onChanged: (_) =>
                  cubit.searchForSentenceOnline(_searchCtrl.text),
            ),
            const SizedBox(height: 12),
            Row(children: [_CountBadge(count: list.length)]),
            const SizedBox(height: 12),
            Expanded(
              child: list.isEmpty
                  ? const NotFoundPage(label: 'No matching sentences')
                  : ListView.separated(
                      itemCount: list.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final item = list[index];
                        return CardSentenceWidget(
                          englishText: item.sentence,
                          arabicText: item.translate,
                          accentColor: AppColors.sentenceAccent,
                          onEdit: () => ItemActionsHelper.showEditSheet(
                            context,
                            docId: item.id,
                            collection: 'sentenceData',
                            currentContent: item.sentence,
                            currentTranslate: item.translate,
                            contentLabel: 'Sentence',
                            contentFieldName: 'sentence',
                          ),
                          onDelete: () => ItemActionsHelper.showDeleteDialog(
                            context,
                            docId: item.id,
                            collection: 'sentenceData',
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}

class _ErrorView extends StatelessWidget {
  final VoidCallback onRetry;
  const _ErrorView({required this.onRetry});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off_rounded, color: Colors.white38, size: 52),
          const SizedBox(height: 16),
          const Text('Failed to load data',
              style: TextStyle(color: Colors.white70, fontSize: 16)),
          const SizedBox(height: 8),
          const Text('Check your connection',
              style: TextStyle(color: Colors.white38, fontSize: 13)),
          const SizedBox(height: 24),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh, color: AppColors.accent),
            label: const Text('Retry',
                style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  final int count;
  const _CountBadge({required this.count});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.format_list_numbered,
              size: 14, color: Colors.white.withValues(alpha: 0.60)),
          const SizedBox(width: 5),
          Text('$count',
              style: const TextStyle(
                  color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
