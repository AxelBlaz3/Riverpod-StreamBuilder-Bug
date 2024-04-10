import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_streambuilder_bug/data/di/providers.dart';
import 'package:riverpod_streambuilder_bug/domain/usecases/get_accounts_usecase.dart';
import 'package:riverpod_streambuilder_bug/domain/usecases/save_fake_accounts_usecase.dart';

part 'providers.g.dart';

@riverpod
Future<GetAccountsUseCase> getAccountsUseCase(GetAccountsUseCaseRef ref) async {
  final accountsRepository = await ref.watch(accountsRepositoryProvider.future);
  return GetAccountsUseCase(accountsRepository: accountsRepository);
}

@riverpod
Future<SaveFakeAccountsUseCase> saveFakeAccountsUseCase(SaveFakeAccountsUseCaseRef ref) async {
  final accountsRepository = await ref.watch(accountsRepositoryProvider.future);
  return SaveFakeAccountsUseCase(accountsRepository: accountsRepository);
}