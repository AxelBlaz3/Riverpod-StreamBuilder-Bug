import 'package:riverpod_streambuilder_bug/domain/repositories/accounts_repository.dart';

class SaveFakeAccountsUseCase {
  final AccountsRepository accountsRepository;

  SaveFakeAccountsUseCase({required this.accountsRepository});

  Future<void> execute() async {
    await accountsRepository.saveFakeAccounts();
  }
}
