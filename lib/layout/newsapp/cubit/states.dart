abstract class newsapp {}

class intialNewsState extends newsapp {}

class changeNewsPages extends newsapp {}

class getBusinessState extends newsapp {}

class SelectBusinessItemState extends newsapp {}

class isDesktopState extends newsapp {}



class getBusinessLoadingState extends newsapp {}

class getSportsState extends newsapp {}

class AppChangeModeState extends newsapp {}

class getSportsLoadingState extends newsapp {}

class getSceinceState extends newsapp {}

class getScienceLoadingState extends newsapp {}

class getSearchState extends newsapp {}

class getSearchLoadingState extends newsapp {}

class getBusinessErrorState extends newsapp {
  final String error;

  getBusinessErrorState(this.error);
}
