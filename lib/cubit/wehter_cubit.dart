import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:wetherapp/models/weather_model.dart';

part 'wehter_state.dart';

class WehterCubit extends Cubit<WehterState> {
  WehterCubit() : super(WehterInitial());

  getWeather(String city) async {
    emit(WehterLoading());
    try {
      Response response = await Dio().get(
          "https://api.openweathermap.org/data/2.5/weather",
          queryParameters: {
            "q": city,
            "appid": "617fa155502531db33aa073c9d0bd886",
          });
      WeatherModel model = WeatherModel.fromJson(response.data);
      emit(WehterLoaded(model));
    } catch (e) {
      emit(WehterError());
    }
  }
}
