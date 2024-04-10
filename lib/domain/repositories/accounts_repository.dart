import 'package:riverpod_streambuilder_bug/domain/models/account.dart';

abstract class AccountsRepository {
  Future<Stream<List<Account>>> syncAccounts();
  Future<void> saveFakeAccounts();
}
