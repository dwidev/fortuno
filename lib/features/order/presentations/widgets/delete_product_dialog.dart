import 'dart:async';
import 'dart:developer';

import 'package:rxdart/subjects.dart';

import '../../../../core/core.dart';

Future<T?> showDeleteProductDialog<T>({
  required BuildContext context,
  required VoidCallback onDelete,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(child: _DeleteProductDialog(onDelete: onDelete));
    },
  );
}

class _DeleteProductDialog extends StatefulWidget {
  final VoidCallback onDelete;

  const _DeleteProductDialog({required this.onDelete});

  @override
  State<_DeleteProductDialog> createState() => _DeleteProductDialogState();
}

class _DeleteProductDialogState extends State<_DeleteProductDialog> {
  Timer? timer;
  BehaviorSubject<double> countDown = BehaviorSubject.seeded(5);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      timer = Timer.periodic(1.seconds, (timer) {
        countDown.stream.first.then((c) {
          countDown.add(c - 1);
        });

        if (timer.tick == 5) {
          context.pop();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    countDown.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width / 3,
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 45,
                child: Center(
                  child: Text(
                    "Perhatian",
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: kSizeS,
                child: ButtonCircleWidget.gradient(
                  icon: CupertinoIcons.clear,
                  onPressed: () {
                    context.pop();
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: kSizeM),
          Text(
            "Data yang sudah dihapus akan dihapus permanen! apakah kamu yakin?",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: kSizeM),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: StreamBuilder(
                    stream: countDown.stream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) Text("Batal (5)");

                      return Text("Batal (${snapshot.data?.toInt()})");
                    },
                  ),
                ),
              ),
              SizedBox(width: kSizeM),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: deleteButtonColor,
                  ),
                  onPressed: widget.onDelete,
                  child: Text("Hapus", style: TextStyle(color: whiteColor)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
