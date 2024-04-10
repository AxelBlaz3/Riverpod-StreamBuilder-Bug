// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_streambuilder_bug/domain/di/providers.dart';
import 'package:riverpod_streambuilder_bug/domain/models/account.dart';

part 'accounts_view_model.g.dart';

@riverpod
class Accounts extends _$Accounts {
  @override
  Future<AccountsUiState> build() async {
    final getAccountsUseCase = await ref.watch(getAccountsUseCaseProvider.future);
    final accountsStream = await getAccountsUseCase.execute();
    return AccountsUiState(accountsStream: accountsStream);
  }
}

class AccountsUiState {
  final Stream<List<Account>> accountsStream;
  AccountsUiState({
    required this.accountsStream,
  });
}
