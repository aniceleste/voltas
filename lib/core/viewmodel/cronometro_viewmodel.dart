import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cronometro_voltas/models/volta_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CronometroViewModel extends ChangeNotifier {
  Duration _tempoTotal = Duration.zero;
  Duration _tempoUltimaVolta = Duration.zero;
  Timer? _timer;
  bool _estaRodando = false;
  final List<Volta> _voltas = [];
  final FlutterLocalNotificationsPlugin _notifier;
  Timer? _pausaTimer;

  CronometroViewModel(this._notifier);

  Duration get tempoTotal => _tempoTotal;
  List<Volta> get voltas => _voltas;
  bool get estaRodando => _estaRodando;

  void _mostrarNotificacao(String titulo, String corpo, {bool persistente = false}) async {
  final androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'cronometro_channel',
    'Cronômetro Notificações',
    importance: Importance.max,
    priority: Priority.high,
    ongoing: persistente,
  );
  final platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

  await _notifier.show(0, titulo, corpo, platformChannelSpecifics);
}

  void _cancelarNotificacao() async {
    await _notifier.cancel(0);
  }

  void iniciar() {
    if (!_estaRodando) {
      _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
        _tempoTotal += Duration(milliseconds: 100);
        notifyListeners();
      });
      _estaRodando = true;
      _mostrarNotificacao('Cronômetro ativo', 'Contando o tempo...', persistente: true);
      _pausaTimer?.cancel();
      notifyListeners();
    }
  }

  void pausar() {
    if (_estaRodando) {
      _timer?.cancel();
      _estaRodando = false;
      _cancelarNotificacao();
      _pausaTimer = Timer(Duration(seconds: 10), () {
        _mostrarNotificacao('Cronômetro pausado', 'Deseja continuar a contagem?');
      });
      notifyListeners();
    }
  }

  void registrarVolta() {
    if (_estaRodando) {
      final novaVolta = Volta(
        numero: _voltas.length + 1,
        tempoVolta: _tempoTotal - _tempoUltimaVolta,
        tempoTotal: _tempoTotal,
      );
      _voltas.insert(0, novaVolta);
      _tempoUltimaVolta = _tempoTotal;

      _mostrarNotificacao(
        'Volta ${novaVolta.numero}',
        'Tempo da volta: ${novaVolta.tempoVolta.inSeconds}s - Total: ${novaVolta.tempoTotal.inSeconds}s',
      );

      notifyListeners();
    }
  }

  void reiniciar() {
    _timer?.cancel();
    _tempoTotal = Duration.zero;
    _tempoUltimaVolta = Duration.zero;
    _voltas.clear();
    _estaRodando = false;
    _cancelarNotificacao();
    _pausaTimer?.cancel();
    notifyListeners();
  }
}