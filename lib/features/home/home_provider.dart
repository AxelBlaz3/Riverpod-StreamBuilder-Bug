import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_streambuilder_bug/domain/di/providers.dart';

part 'home_provider.g.dart';

@riverpod
class Home extends _$Home {
  @override
  void build() {
    return;
  }

  Future<void> saveFakeAccounts() async {
    final saveFakeAccountsUseCase =
        await ref.watch(saveFakeAccountsUseCaseProvider.future);
    return await saveFakeAccountsUseCase.execute();
  }
}
