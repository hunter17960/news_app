// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  NewsLayout({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: const Icon(
                  Icons.search,
                ),
              )
            ],
            leading: IconButton(
              icon: Icon(
                  cubit.isDark ? cubit.themeIconDark : cubit.themeIconLight),
              onPressed: () {
                cubit.toggleTheme();
              },
            ),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (value) {
              cubit.changeIndex(value);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.business_center,
                ),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.science,
                ),
                label: 'Science',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.sports,
                ),
                label: 'Sports',
              ),
            ],
          ),
        );
      },
    );
  }

  // void clearFormField() {
  //   titleController.clear();
  //   timeController.clear();
  //   dateController.clear();
  // }
}
// create db
// create tables
// open db
// insert to db
// get from db
// update db
// delete from db
