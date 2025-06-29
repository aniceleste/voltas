import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cronometro_voltas/core/viewmodel/cronometro_viewmodel.dart';

class CronometroView extends StatelessWidget {
  const CronometroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Semantics(
          label: 'Cronômetro de Voltas - Aplicativo para cronometrar voltas',
          child: Text('Cronômetro de Voltas'),
        ),
      ),
      body: Semantics(
        label: 'Tela principal do cronômetro com controles e lista de voltas',
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Sección del cronómetro principal
              Semantics(
                label: 'Display do tempo total do cronômetro',
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.blue[200]!.withValues(alpha: 0.2),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Consumer<CronometroViewModel>(
                      builder: (_, viewModel, __) {
                        final minutos = viewModel.tempoTotal.inMinutes;
                        final segundos = (viewModel.tempoTotal.inSeconds % 60)
                            .toString()
                            .padLeft(2, '0');
                        final milis =
                            (viewModel.tempoTotal.inMilliseconds % 1000 ~/ 100);
                        final tempoString = '$minutos:$segundos.$milis';

                        return Semantics(
                          label:
                              'Tempo atual: $minutos minutos, $segundos segundos e $milis décimos de segundo',
                          child: Text(
                            tempoString,
                            style: Theme.of(
                              context,
                            ).textTheme.headlineLarge?.copyWith(
                              color: Colors.blue[800],
                              fontFamily: 'monospace',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24.0),

              // Sección de controles
              Semantics(
                label: 'Controles do cronômetro',
                child: Consumer<CronometroViewModel>(
                  builder: (_, viewModel, __) {
                    return Column(
                      children: [
                        // Primera fila de botones
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Semantics(
                              label:
                                  viewModel.estaRodando
                                      ? 'Botão iniciar desabilitado - cronômetro já está rodando'
                                      : 'Botão para iniciar o cronômetro',
                              button: true,
                              enabled: !viewModel.estaRodando,
                              child: ElevatedButton(
                                onPressed:
                                    viewModel.estaRodando
                                        ? null
                                        : viewModel.iniciar,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      viewModel.estaRodando
                                          ? Colors.grey[400]
                                          : Colors.green[600],
                                  minimumSize: Size(100, 56),
                                ),
                                child: Icon(
                                  Icons.play_arrow,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            Semantics(
                              label:
                                  viewModel.estaRodando
                                      ? 'Botão para pausar o cronômetro'
                                      : 'Botão pausar desabilitado - cronômetro não está rodando',
                              button: true,
                              enabled: viewModel.estaRodando,
                              child: ElevatedButton(
                                onPressed:
                                    viewModel.estaRodando
                                        ? viewModel.pausar
                                        : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      viewModel.estaRodando
                                          ? Colors.orange[600]
                                          : Colors.grey[400],
                                  minimumSize: Size(100, 56),
                                ),
                                child: Icon(
                                  Icons.pause,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16.0),

                        // Segunda fila de botones
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Semantics(
                              label:
                                  'Botão para registrar uma nova volta no cronômetro',
                              button: true,
                              child: ElevatedButton(
                                onPressed: viewModel.registrarVolta,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[600],
                                  minimumSize: Size(100, 56),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.flag,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Volta',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Semantics(
                              label:
                                  'Botão para reiniciar o cronômetro e limpar todas as voltas',
                              button: true,
                              child: ElevatedButton(
                                onPressed: viewModel.reiniciar,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red[600],
                                  minimumSize: Size(100, 56),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.refresh,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Reiniciar',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),

              SizedBox(height: 24.0),

              // Sección de lista de voltas
              Semantics(
                label: 'Lista de voltas registradas',
                child: Consumer<CronometroViewModel>(
                  builder: (_, viewModel, __) {
                    if (viewModel.voltas.isEmpty) {
                      return Semantics(
                        label: 'Nenhuma volta registrada ainda',
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Center(
                            child: Text(
                              'Nenhuma volta registrada',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.copyWith(
                                color: Colors.grey[600],
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    return Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.blue[200]!.withValues(alpha: 0.2),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 4.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        itemCount: viewModel.voltas.length,
                        itemBuilder: (context, index) {
                          final volta = viewModel.voltas[index];
                          final tempoVoltaMin = volta.tempoVolta.inMinutes;
                          final tempoVoltaSeg = (volta.tempoVolta.inSeconds %
                                  60)
                              .toString()
                              .padLeft(2, '0');
                          final tempoVoltaMilis =
                              (volta.tempoVolta.inMilliseconds % 1000 ~/ 100);
                          final tempoTotalMin = volta.tempoTotal.inMinutes;
                          final tempoTotalSeg = (volta.tempoTotal.inSeconds %
                                  60)
                              .toString()
                              .padLeft(2, '0');
                          final tempoTotalMilis =
                              (volta.tempoTotal.inMilliseconds % 1000 ~/ 100);

                          return Semantics(
                            label:
                                'Volta número ${volta.numero}. Tempo da volta: $tempoVoltaMin minutos, $tempoVoltaSeg segundos e $tempoVoltaMilis décimos. Tempo total acumulado: $tempoTotalMin minutos, $tempoTotalSeg segundos e $tempoTotalMilis décimos',
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 4.0,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    index % 2 == 0
                                        ? Colors.blue[50]
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(color: Colors.blue[100]!),
                              ),
                              child: ListTile(
                                leading: Semantics(
                                  label: 'Número da volta ${volta.numero}',
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[600],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${volta.numero}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                title: Semantics(
                                  label: 'Tempo da volta ${volta.numero}',
                                  child: Text(
                                    'Volta ${volta.numero} - $tempoVoltaMin:$tempoVoltaSeg.$tempoVoltaMilis',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue[800],
                                    ),
                                  ),
                                ),
                                subtitle: Semantics(
                                  label:
                                      'Tempo total acumulado até a volta ${volta.numero}',
                                  child: Text(
                                    'Total: $tempoTotalMin:$tempoTotalSeg.$tempoTotalMilis',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      color: Colors.grey[700],
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                ),
                                trailing: Semantics(
                                  label:
                                      'Ícone indicando que esta é a volta número ${volta.numero}',
                                  child: Icon(
                                    Icons.flag,
                                    color: Colors.blue[600],
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
