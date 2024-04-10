import 'package:riverpod_streambuilder_bug/domain/models/account.dart';
import 'package:riverpod_streambuilder_bug/domain/repositories/accounts_repository.dart';

class GetAccountsUseCase {
  final AccountsRepository accountsRepository;

  GetAccountsUseCase({required this.accountsRepository});

  Future<Stream<List<Account>>> execute() async {
    return await accountsRepository.syncAccounts();
  }
}
