import 'package:get_it/get_it.dart';

import '../../features/operation/controllers/operation_controller.dart';
import '../../features/operation/data/datasources/supervisor_datasource.dart';
import '../../features/operation/data/repositories/supervisor_repository.dart';
import '../network/server_address.dart';
import '../network/socket_client.dart';

final getIt = GetIt.instance;


void configureDependencies() {
  getIt.registerLazySingleton<SocketClient>(
    () => SocketClient(url: ServerAddress.rosbridgeUrl),
  );

  getIt.registerLazySingleton<SupervisorDatasource>(
    () => SupervisorDatasource(getIt<SocketClient>()),
  );

  getIt.registerLazySingleton<SupervisorRepository>(
    () => SupervisorRepository(getIt<SupervisorDatasource>()),
  );

  getIt.registerLazySingleton<OperationController>(
    () => OperationController(getIt<SupervisorRepository>()),
  );
}
