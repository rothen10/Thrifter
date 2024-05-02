// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/use_case/use_case.dart';
import 'package:thrifter/features/intro/domain/entities/country_entity.dart';
import 'package:thrifter/features/intro/domain/use_case/get_contries_user_case.dart';
import 'package:thrifter/features/intro/domain/use_case/get_selected_country_use_case.dart';
import 'package:thrifter/features/intro/domain/use_case/save_selected_country_use_case.dart';

part 'country_picker_cubit.freezed.dart';

@injectable
class CountryPickerCubit extends Cubit<CountryPickerState> {
  CountryPickerCubit(
    this.getCountryUseCase,
    this.getSelectedCountryUseCase,
    this.saveSelectedCountryUseCase,
  ) : super(CountryPickerState.countries());

  final GetCountriesUseCase getCountryUseCase;
  final GetSelectedCountryUseCase getSelectedCountryUseCase;
  final SaveSelectedCountryUseCase saveSelectedCountryUseCase;

  void fetchCountry() {
    final List<CountryEntity> countries = getCountryUseCase(NoParams());
    final CountryEntity? selectedCountry =
        getSelectedCountryUseCase(NoParams());
    emit(CountryPickerState.countries(
      countries: countries,
      selectedCountry: selectedCountry,
    ));
  }

  void filterCountry(String value) {
    final List<CountryEntity> filterCountries = getCountryUseCase(NoParams())
        .where(
          (element) =>
              element.name.toLowerCase().contains(value.toLowerCase()) ||
              element.code.toLowerCase().contains(value.toLowerCase()),
        )
        .toList();
    emit(CountryPickerState.countries(
      countries: filterCountries,
      selectedCountry: state.selectedCountry,
    ));
  }

  void updateSelectedCountry(CountryEntity countryEntity) {
    saveSelectedCountryUseCase(
      ParamsSaveCountry(countryEntity),
    );
    emit(state.copyWith(selectedCountry: countryEntity));
  }
}

@freezed
class CountryPickerState with _$CountryPickerState {
  //factory CountryPickerState.initial() = _CountryInitial;
  factory CountryPickerState.countries({
    @Default([]) List<CountryEntity> countries,
    CountryEntity? selectedCountry,
  }) = CountriesLoadedState;

  //factory CountryPickerState.navigateToLanding() = NavigateToLanding;
}
