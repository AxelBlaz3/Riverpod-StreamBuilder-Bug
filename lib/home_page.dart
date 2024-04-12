import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_streambuilder_bug/accounts_page.dart';
import 'package:riverpod_streambuilder_bug/providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "How to reproduce?",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 16.0,
            ),
            const Text(
                'Steps to reproduce:\n1. Click on "Create fake accounts" FAB once.\n2.Go to accounts page to confirm if you can see accounts list.\n3.Come back to home page.\n4. Immediately go to accounts page again!.\n\nYou might see Bad state: Stream has already been listened to (this can be fixed by adding asBroadcastStream()). However, after adding that, instead of stream error, I see connectionState always "waiting".'),
            const SizedBox(
              height: 16.0,
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AccountsPage(),
                ));
              },
              child: const Text('Go to accounts list'),
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Text(
                'Click on the FAB to add fake accounts to local DB. Clicking once is enough!'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await saveFakeAccounts();
          },
          label: const Text('Create fake accounts')),
    );
  }
}
