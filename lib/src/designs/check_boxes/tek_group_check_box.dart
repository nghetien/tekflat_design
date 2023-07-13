part of 'check_boxes.dart';

// @Deprecated('Hiện tại không nên dùng vì sau này còn nhiều chỉnh sửa')
// class TekGroupCheckBox extends StatefulWidget {
//   const TekGroupCheckBox({
//     Key? key,
//     this.height,
//     this.width,
//     this.initValue,
//     this.listTitle,
//     this.listWidget,
//     this.type = TekCheckBoxType.check,
//     this.canUnSelect = true,
//     required this.onChanged,
//     this.activeColor,
//     this.checkColor,
//     this.space,
//     this.titleWidget,
//     this.title,
//     this.textStyle,
//   })  : assert(
//             (listTitle != null && listWidget == null) || (listTitle == null && listWidget != null),
//             'each of listTitle and listWidget must be null'),
//         assert(
//             initValue == null ||
//                 (listTitle != null && listWidget == null && initValue.length == listTitle.length) ||
//                 (listTitle == null && listWidget != null && initValue.length == listWidget.length),
//             'initValue length must be equal to listTitle or listWidget length'),
//         super(key: key);
//
//   final double? height;
//   final double? width;
//   final List<bool>? initValue;
//   final List<String>? listTitle;
//   final List<Widget>? listWidget;
//   final TekCheckBoxType type;
//   final bool canUnSelect;
//   final Function(int, bool?) onChanged;
//   final Color? activeColor;
//   final Color? checkColor;
//   final double? space;
//   final Widget? titleWidget;
//   final String? title;
//   final TextStyle? textStyle;
//
//   @override
//   State<TekGroupCheckBox> createState() => TekGroupCheckBoxState();
// }
//
// class TekGroupCheckBoxState extends State<TekGroupCheckBox> {
//   late List<dynamic> _listItem = [];
//   late List<bool> _listResult = [];
//   int _currentSelected = -1;
//
//   List<bool> get resultSelected => _listResult;
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.listTitle != null) {
//       _listItem = widget.listTitle!;
//     } else if (widget.listWidget != null) {
//       _listItem = widget.listWidget!;
//     }
//     if (widget.initValue != null) {
//       _listResult = widget.initValue!;
//     } else {
//       _listResult = List.generate(_listItem.length, (index) => false);
//     }
//   }
//
//   void _onSelect(int index, bool value) {
//     if (widget.type.isCheck) {
//       setState(() => _listResult[index] = value);
//     } else {
//       _listResult = List.generate(_listResult.length, (index) => false);
//       if (widget.canUnSelect) {
//         _listResult[index] = value;
//         if (_listResult[index]) {
//           setState(() => _currentSelected = index);
//         } else {
//           setState(() => _currentSelected = -1);
//         }
//       } else {
//         if (_currentSelected == index && !value) {
//           _listResult[index] = !value;
//         } else {
//           _listResult[index] = value;
//           setState(() => _currentSelected = index);
//         }
//       }
//     }
//     widget.onChanged(index, _listResult[index]);
//   }
//
//   bool _isSelected(int index) {
//     if (widget.type.isCheck) return _listResult[index];
//     return _currentSelected == index;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: widget.height,
//       width: widget.width,
//       child: ListView.builder(
//         itemCount: _listItem.length,
//         itemBuilder: (context, index) {
//           return InkWell(
//             onTap: () => _onSelect(index, !_listResult[index]),
//             child: TekCheckBoxTitle(
//               type: widget.type,
//               value: _isSelected(index),
//               onChanged: (value) {
//                 if (value != null) _onSelect(index, value);
//               },
//               activeColor: widget.activeColor,
//               checkColor: widget.checkColor,
//               space: widget.space,
//               titleWidget: widget.listWidget != null ? _listItem[index] as Widget : null,
//               title: widget.listTitle != null ? _listItem[index] as String : null,
//               textStyle: widget.textStyle,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
