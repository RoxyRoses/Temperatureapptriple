import 'package:mobx_triple/mobx_triple.dart';
import 'package:temperatureapp/model/forecast_repository.dart';

class ForecastStore extends MobXStore<Exception, String> {
  ForecastStore() : super('');

  Future<void> add() async {
    try {
      setLoading(true);
      await Future.delayed(const Duration(seconds: 2));
      update(state);
      setLoading(false);
    } catch (e) {
      setError(Exception(e));
    }
  }
}
