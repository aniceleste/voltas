import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cronometro_voltas/core/viewmodel/cronometro_viewmodel.dart';

class CronometroView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cronômetro de Voltas')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Semantics(
              label: 'Tempo total do cronômetro',
              child: Container(
                height: 200,
                child: Center(
                  child: Consumer<CronometroViewModel>(
                    builder: (_, viewModel, __) {
                      final minutos = viewModel.tempoTotal.inMinutes;
                      final segundos = (viewModel.tempoTotal.inSeconds % 60).toString().padLeft(2, '0');
                      final milis = (viewModel.tempoTotal.inMilliseconds % 1000 ~/ 100);
                      return Text(
                        '$minutos:$segundos.$milis',
                        style: TextStyle(fontSize: 40),
                      );
                    },
                  ),
                ),
              ),
            ),
            Consumer<CronometroViewModel>(
              builder: (_, viewModel, __) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Semantics(
                          label: 'Botão iniciar',
                          child: ElevatedButton(
                            onPressed: viewModel.estaRodando ? null : viewModel.iniciar,
                            child: Text('Iniciar'),
                          ),
                        ),
                        Semantics(
                          label: 'Botão pausar',
                          child: ElevatedButton(
                            onPressed: viewModel.estaRodando ? viewModel.pausar : null,
                            child: Text('Pausar'),
                          ),
                        ),
                        Semantics(
                          label: 'Botão registrar volta',
                          child: ElevatedButton(
                            onPressed: viewModel.registrarVolta,
                            child: Text('Volta'),
                          ),
                        ),
                        Semantics(
                          label: 'Botão reiniciar',
                          child: ElevatedButton(
                            onPressed: viewModel.reiniciar,
                            child: Text('Reiniciar'),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        itemCount: viewModel.voltas.length,
                        itemBuilder: (context, index) {
                          final volta = viewModel.voltas[index];
                          return Semantics(
                            label: 'Volta número ${volta.numero}, tempo da volta ${volta.tempoVolta.inSeconds} segundos, tempo total ${volta.tempoTotal.inSeconds} segundos',
                            child: ListTile(
                              title: Text('Volta ${volta.numero} - ${volta.tempoVolta.inSeconds}s'),
                              subtitle: Text('Tempo Total: ${volta.tempoTotal.inSeconds}s'),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
