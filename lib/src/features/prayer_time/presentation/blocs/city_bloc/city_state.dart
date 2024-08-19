part of 'city_bloc.dart';

@immutable
sealed class CityState {}

final class CityInitial extends CityState {}

final class CityLoading extends CityState {}

final class CityLoaded extends CityState {
  final List<City> cities;

  CityLoaded(this.cities);
}
