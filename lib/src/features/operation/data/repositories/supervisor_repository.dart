import '../../models/connection_status.dart';
import '../datasources/supervisor_datasource.dart';


class SupervisorRepository {
  SupervisorRepository(this._datasource);

  final SupervisorDatasource _datasource;

  Stream<ConnectionStatus> get statusStream => _datasource.statusStream;

  Future<void> connect() => _datasource.connect();

  void sendCommand(String command) => _datasource.sendCommand(command);

  Future<void> dispose() => _datasource.dispose();
}
