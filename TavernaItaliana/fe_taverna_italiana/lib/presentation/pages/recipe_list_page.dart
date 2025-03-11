import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taverna_italiana/core/styles/app_colors.dart';
import 'package:taverna_italiana/domain/entities/recipe.dart';
import 'package:taverna_italiana/presentation/providers/recipe_notifier_provider.dart';
import 'package:taverna_italiana/presentation/pages/local_widget/recipe_filter_widget.dart';

class RecipePage extends HookConsumerWidget {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = useState<String>('Tutti');

    final recipesAsync = ref.watch(recipeNotifierProvider);

    void onFilterSelected(String category) {
      selectedCategory.value = category;
      ref.read(recipeNotifierProvider.notifier).filterByCategory(category);
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        surfaceTintColor: AppColors.white,
        backgroundColor: AppColors.white,
        title: SvgPicture.asset(
          'assets/logo.svg',
          height: 48,
        ),
      ),
      body: recipesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Errore: $error')),
        data: (recipes) => Column(
          children: [
            const SizedBox(height: 8),
            RecipeFilterWidget(
              filters: const ['Tutti', 'Antipasto', 'Primo Piatto', 'Dessert'],
              onSelected: (category) => onFilterSelected(category),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await ref
                      .read(recipeNotifierProvider.notifier)
                      .refreshRecipes();
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final Recipe recipe = recipes[index];
                    return ListTile(
                      title: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 200.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(recipe.imgUrl),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              alignment: Alignment.bottomLeft,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black, // nero intenso sotto
                                    Colors.black,
                                    Colors.transparent, // trasparente in alto
                                  ],
                                ),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(16.0),
                                    bottomRight: Radius.circular(16.0)),
                              ),
                              height: 80,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(recipe.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.white)),
                                      Text(
                                          '${recipe.region} • ${recipe.category}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white)),
                                    ],
                                  ),
                                  const Spacer(),
                                  SvgPicture.asset(
                                    'assets/italy.svg',
                                    height: 48,
                                    colorFilter: const ColorFilter.mode(
                                        Colors.white, BlendMode.srcIn),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
