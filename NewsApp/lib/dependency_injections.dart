import 'package:injector/injector.dart';
import 'data/api/api_service.dart';
import 'data/providers/home_provider.dart';
import 'data/repositories/home_repository.dart';

void setupDependencyInjections() async {
  Injector injector = Injector.appInstance;
  injector.registerSingleton<ApiService>(() => ApiService());



  _homeRepositoryDependencyDI(injector);
  _homeProviderDependencyDI(injector);

}

// HOME
void _homeRepositoryDependencyDI(Injector injector) {
  injector.registerDependency<HomeRepository>(() {
    HomeProvider homeProvider = injector.get<HomeProvider>();
    return HomeRepository(homeProvider: homeProvider);
  });
}

void _homeProviderDependencyDI(Injector injector) {
  injector.registerDependency<HomeProvider>(() {
    ApiService api = injector.get<ApiService>();
    return HomeProvider(api: api);
  });
}

