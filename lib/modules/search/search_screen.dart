import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<dynamic> articles = NewsCubit.get(context).search;
        return PopScope(
          canPop: true,
          onPopInvoked: (didPop) {
            articles = [];
            NewsCubit.get(context).clearSearch();
            searchController.clear();
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  articles = [];
                  NewsCubit.get(context).clearSearch();
                  searchController.clear();
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    onChange: (value) {
                      // searchController.text = value;
                      NewsCubit.get(context).getSearch(value);
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'search must not be null';
                      }
                      return null;
                    },
                    label: 'Search',
                    prefix: Icons.search,
                  ),
                ),
                Expanded(
                    child:
                        articlePageBuilder(articles, context, isSearch: true)),
              ],
            ),
          ),
        );
      },
    );
  }
}
