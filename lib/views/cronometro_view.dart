import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cronometro_voltas/core/viewmodel/cronometro_viewmodel.dart';

class CronometroView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cronômetro de Voltas')),
      body: SingleChildScrollView(  // Envuelve el Column en un SingleChildScrollView
        child: Column(
          children: [
            // Cronômetro que muestra el tiempo total
            Expanded(
              child: Center(
                child: Consumer<CronometroViewModel>(
                  builder: (_, viewModel, __) {
                    return Text(
                      '${viewModel.tempoTotal.inMinutes}:${(viewModel.tempoTotal.inSeconds % 60).toString().padLeft(2, '0')}.${(viewModel.tempoTotal.inMilliseconds % 1000 ~/ 100)}',
                      style: TextStyle(fontSize: 40),
                    );
                  },
                ),
              ),
            ),

            // Botones para controlar el cronômetro y mostrar las voltas
            Consumer<CronometroViewModel>(
              builder: (_, viewModel, __) {
                return Column(
                  children: [
                    // Botones de control (Iniciar, Pausar, Volta, Reiniciar)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: viewModel.estaRodando ? null : viewModel.iniciar,
                          child: Text('Iniciar'),
                        ),
                        ElevatedButton(
                          onPressed: viewModel.estaRodando ? viewModel.pausar : null,
                          child: Text('Pausar'),
                        ),
                        ElevatedButton(
                          onPressed: viewModel.registrarVolta,
                          child: Text('Volta'),
                        ),
                        ElevatedButton(
                          onPressed: viewModel.reiniciar,
                          child: Text('Reiniciar'),
                        ),
                      ],
                    ),

                    // Lista de voltas registradas
                    Expanded(
                      child: ListView.builder(
                        itemCount: viewModel.voltas.length,
                        itemBuilder: (context, index) {
                          final volta = viewModel.voltas[index];
                          return ListTile(
                            title: Text('Volta ${volta.numero} - ${volta.tempoVolta.inSeconds}s'),
                            subtitle: Text('Tempo Total: ${volta.tempoTotal.inSeconds}s'),
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

