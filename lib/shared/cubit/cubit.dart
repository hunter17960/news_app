import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  static NewsCubit get(context) => BlocProvider.of(context);
  bool isDark = false;
  IconData themeIconDark = Icons.light_mode;
  IconData themeIconLight = Icons.dark_mode;
  int currentIndex = 0;
  List<Widget> screens = [
    const BusinessScreen(),
    const ScienceScreen(),
    const SportsScreen(),
  ];
  List<String> titles = [
    'Business Screen',
    'Science Screen',
    'Sports Screen',
  ];
  List<dynamic> business = [];
  List<dynamic> science = [];
  List<dynamic> sports = [];
  List<dynamic> search = [];
  void getBusiness() {
    emit(NewsGetBusinessDataLoading());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': 'business',
        'apiKey': '164cfc03aa0843a4835f85bd54f3ed6c',
      },
    ).then((value) {
      business = value.data['articles'];
      business[0]['title'];
      emit(NewsGetBusinessDataSuccess());
    }).catchError((error) {
      // print(error.toString());
      emit(NewsGetBusinessDataFailure(error.toString()));
    });
  }

  void getScience() {
    emit(NewsGetScienceDataLoading());
    if (science.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'science',
          'apiKey': '164cfc03aa0843a4835f85bd54f3ed6c',
        },
      ).then((value) {
        science = value.data['articles'];
        science[0]['title'];
        emit(NewsGetScienceDataSuccess());
      }).catchError((error) {
        // print(error.toString());
        emit(NewsGetScienceDataFailure(error.toString()));
      });
    } else {
      emit(NewsGetScienceDataSuccess());
    }
  }

  void getSports() {
    emit(NewsGetSportsDataLoading());
    if (sports.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'sports',
          'apiKey': '164cfc03aa0843a4835f85bd54f3ed6c',
        },
      ).then((value) {
        sports = value.data['articles'];
        sports[0]['title'];
        emit(NewsGetSportsDataSuccess());
      }).catchError((error) {
        // print(error.toString());
        emit(NewsGetSportsDataFailure(error.toString()));
      });
    } else {
      emit(NewsGetSportsDataSuccess());
    }
  }

  void getSearch(String value) {
    emit(NewsGetSearchDataLoading());
    search = [];
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': value,
        'apiKey': '164cfc03aa0843a4835f85bd54f3ed6c',
      },
    ).then((value) {
      search = value.data['articles'];
      search[0]['title'];
      emit(NewsGetSearchDataSuccess());
    }).catchError((error) {
      // print(error.toString());
      emit(NewsGetSearchDataFailure(error.toString()));
    });
  }

  void clearSearch() {
    search = [];
  }

  void changeIndex(int index) {
    currentIndex = index;
    if (index == 0) {
      getBusiness();
    }
    if (index == 1) {
      getScience();
    }
    if (index == 2) {
      getSports();
    }

    emit(NewsChangeBottomNavBar());
  }

  void toggleTheme({bool? storedIsDark}) {
    if (storedIsDark != null) {
      isDark = storedIsDark;
      emit(NewsToggleTheme());
    } else {
      isDark = !isDark;
      CacheHelper.setBoolean(key: 'isDark', value: isDark).then((value) {
        emit(NewsToggleTheme());
      });
    }
  }
}
