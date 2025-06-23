import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inboard_personal_project/features/whiteboard/presentation/blocs/whiteboard_main_bloc/whiteboard_main_bloc.dart';
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
              IconButton(
                icon: Icon(state.isZoomMode ? Icons.pan_tool : Icons.edit),
                onPressed: () => context.read<WhiteboardMainBloc>().add(ToggleZoomMode()),
              ),
            ],
          ),
          body: LayoutBuilder(
            builder: (_, constraints) {
              return Listener(
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
                    child: CustomPaint(painter: WhiteboardPainter(drawingPoints: state.drawingPoint)),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
