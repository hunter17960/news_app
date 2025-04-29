abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsChangeBottomNavBar extends NewsState {}

class NewsGetBusinessDataLoading extends NewsState {}

class NewsGetBusinessDataSuccess extends NewsState {}

class NewsGetBusinessDataFailure extends NewsState {
  final String error;
  NewsGetBusinessDataFailure(this.error);
}

class NewsGetScienceDataLoading extends NewsState {}

class NewsGetScienceDataSuccess extends NewsState {}

class NewsGetScienceDataFailure extends NewsState {
  final String error;
  NewsGetScienceDataFailure(this.error);
}

class NewsGetSportsDataLoading extends NewsState {}

class NewsGetSportsDataSuccess extends NewsState {}

class NewsGetSportsDataFailure extends NewsState {
  final String error;
  NewsGetSportsDataFailure(this.error);
}

class NewsGetSearchDataLoading extends NewsState {}

class NewsGetSearchDataSuccess extends NewsState {}

class NewsGetSearchDataFailure extends NewsState {
  final String error;
  NewsGetSearchDataFailure(this.error);
}

class NewsToggleTheme extends NewsState {}
