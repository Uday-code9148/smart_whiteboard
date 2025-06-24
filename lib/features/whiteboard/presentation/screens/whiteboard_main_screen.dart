import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inboard_personal_project/core/services/di_services/service_locator.dart' show getIt;
import 'package:inboard_personal_project/features/whiteboard/presentation/blocs/whiteboard_main_bloc/whiteboard_main_bloc.dart';
import 'package:inboard_personal_project/features/whiteboard/presentation/items/initialized_center_categories.dart';
import 'package:inboard_personal_project/features/whiteboard/presentation/items/initialized_left_categories.dart';
import 'package:inboard_personal_project/features/whiteboard/presentation/items/initialized_right_categories.dart';
import 'package:inboard_personal_project/features/whiteboard/presentation/widgets/horizontal_pop_up_widget.dart';
import 'package:inboard_personal_project/features/whiteboard/presentation/widgets/painter_widget.dart';

class WhiteboardMainScreen extends StatefulWidget {
  const WhiteboardMainScreen({super.key});

  @override
  State<WhiteboardMainScreen> createState() => _WhiteboardMainScreenState();
}

class _WhiteboardMainScreenState extends State<WhiteboardMainScreen> {
  late TransformationController _controller;

  @override
  void initState() {
    super.initState();
    getIt<WhiteboardMainBloc>().add(WhiteboardMainInitialEvent(context));
  }

  Offset _transformPointer(Offset localPosition) {
    final inverseMatrix = Matrix4.inverted(_controller.value);
    return MatrixUtils.transformPoint(inverseMatrix, localPosition);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WhiteboardMainBloc, WhiteboardMainState>(
      listener: (_, __) {},
      builder: (context, state) {
        _controller = context.read<WhiteboardMainBloc>().controller;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Whiteboard'),
            actions: [
              IconButton(icon: const Icon(Icons.delete), onPressed: () => context.read<WhiteboardMainBloc>().add(ClearCanvasEvent())),
              IconButton(
                icon: const Icon(Icons.zoom_out_map),
                onPressed: () => context.read<WhiteboardMainBloc>().controller.value = Matrix4.identity(),
              ),
              IconButton(icon: Icon(state.isZoomMode ? Icons.pan_tool : Icons.edit), onPressed: () {}),
            ],
          ),
          body: LayoutBuilder(
            builder: (_, constraints) {
              return Stack(
                children: [
                  Listener(
                    onPointerDown: state.isZoomMode
                        ? null
                        : (event) {
                            final local = event.localPosition;
                            final pos = _transformPointer(local);
                            context.read<WhiteboardMainBloc>().add(PanStartEvent(points: pos));
                          },
                    onPointerMove: state.isZoomMode
                        ? null
                        : (event) {
                            final local = event.localPosition;
                            final pos = _transformPointer(local);
                            context.read<WhiteboardMainBloc>().add(PanUpdateEvent(points: pos));
                          },
                    onPointerUp: state.isZoomMode
                        ? null
                        : (_) {
                            context.read<WhiteboardMainBloc>().add(PanEndEvent());
                          },
                    child: InteractiveViewer(
                      transformationController: _controller,
                      constrained: false,
                      panEnabled: state.isZoomMode,
                      scaleEnabled: state.isZoomMode,
                      minScale: 0.5,
                      maxScale: 5.0,
                      child: Container(
                        width: 3000,
                        height: 3000,
                        color: Colors.white,
                        child: CustomPaint(
                          painter: WhiteboardPainter(
                            drawingPoints: [
                              ...state.drawingPoint,
                              ...[?state.currentDrawingPoint],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: MediaQuery.of(context).size.width * 0.37,
                    bottom: 50,
                    child: HorizontalIconPopup(feature: centerFeature),
                  ),
                  Positioned(right: 0, bottom: 50, child: HorizontalIconPopup(feature: leftFeature)),
                  Positioned(left: 0, bottom: 50, child: HorizontalIconPopup(feature: rightFeature)),
                  Positioned(
                    right: MediaQuery.of(context).size.width * 0.02,
                    bottom: MediaQuery.of(context).size.height * 0.3,
                    child: loader("Recognizing ........."),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget loader(String? loaderText) {
    return Container(
      height: 45,
      width: 260,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(11)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 20, child: CircularProgressIndicator(color: Colors.brown, strokeWidth: 2)),
          Text(loaderText ?? "Loading ..", style: TextStyle(color: Colors.brown, fontSize: 14)),
        ],
      ),
    );
  }
}
