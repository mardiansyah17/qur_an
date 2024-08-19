part of 'city_bloc.dart';

@immutable
sealed class CityEvent {}

final class LoadedCities extends CityEvent {}

final class SearchCityByQuery extends CityEvent {
  final String query;

  SearchCityByQuery(this.query);
}
