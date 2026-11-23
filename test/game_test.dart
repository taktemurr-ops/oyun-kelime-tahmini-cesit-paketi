import 'package:flutter_test/flutter_test.dart';
import 'package:oyun_kelime_tahmini_cesit_paketi/oyun_kelime_tahmini_cesit_paketi.dart';
import 'package:studio_core/core/level_plan.dart';

void main() {
  test('paket: 8 çeşit, 33 dil, kimlikler tutarlı', () {
    expect(kelimeTahminiGroup.games.length, 8);
    expect(kelimeTahminiGroup.title.length, 33);
    for (final g in kelimeTahminiGroup.games) {
      expect(g.title.length, 33);
      expect(g.tagline.length, 33);
      expect(g.rules.gameId, g.gameId);
    }
  });

  test('her çeşidin bölümleri kurulur', timeout: const Timeout(Duration(minutes: 10)), () {
    for (final g in kelimeTahminiGroup.games) {
      final planner = LevelPlanner(gameId: g.gameId, optionalMechanics: g.rules.optionalMechanics);
      for (final lv in [1, 500, 99999]) {
        expect(g.rules.build(planner.spec(lv)).validation.ok, isTrue, reason: '${g.gameId} $lv');
      }
    }
  });
}
