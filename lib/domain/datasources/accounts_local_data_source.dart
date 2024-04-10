import 'package:riverpod_streambuilder_bug/database/entities/account_entity.dart';

abstract class AccountsLocalDataSource {
  Stream<List<AccountEntity>> getAllAccountsStream();
  Future<void> saveFakeAccounts();
}
