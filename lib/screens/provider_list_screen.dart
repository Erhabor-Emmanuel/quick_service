import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/provider_model.dart';
import '../widgets/loading_shimmer.dart';
import '../widgets/provider_card.dart';



class ProviderListState extends ChangeNotifier {
  bool isLoading = true;
  List<CardProvider> allProviders = [];
  List<CardProvider> filteredProviders = [];
  String searchText = '';


  Future<void> loadProviders() async {
    await Future.delayed(const Duration(seconds: 1));
    allProviders = getAllProviders();
    filteredProviders = allProviders;
    isLoading = false;
    notifyListeners();
  }


  void filterProviders(String text) {
    searchText = text;

    if (text.isEmpty) {

      filteredProviders = allProviders;
    } else {

      filteredProviders = allProviders.where((provider) {
        return provider.name.toLowerCase().contains(text.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }


  void clearSearch() {
    searchText = '';
    filteredProviders = allProviders;
    notifyListeners();
  }
}


class ProviderListScreen extends StatelessWidget {
  const ProviderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final state = ProviderListState();
        state.loadProviders();
        return state;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text('QuickService'),
          backgroundColor: const Color(0xFF2E7D32),
          foregroundColor: Colors.white,
        ),
        body: Consumer<ProviderListState>(
          builder: (context, state, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    onChanged: (text) => state.filterProviders(text),
                    decoration: InputDecoration(
                      hintText: 'Search providers...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: state.searchText.isNotEmpty
                          ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => state.clearSearch(),
                      )
                          : null,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: state.isLoading
                      ? ListView.builder(
                    itemCount: 6,
                    itemBuilder: (_, __) => const LoadingCardShimmer(),
                  )
                      : state.filteredProviders.isEmpty
                      ? const Center(
                    child: Text(
                      'No providers found',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  )
                      : ListView.builder(
                    itemCount: state.filteredProviders.length,
                    itemBuilder: (context, index) {
                      final provider = state.filteredProviders[index];
                      return ProviderCard(
                        provider: provider,
                        onBookPressed: () {

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