import 'package:flutter/material.dart';
import 'package:tekflat_design/src/designs/data_table_reorderable/data_table_reorderable.dart';
import 'package:tekflat_design/tekflat_design.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: TekThemes.light,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class DemoDataTableModel {
  final int id;
  final String userName;
  final String gender;
  final String email;

  const DemoDataTableModel({
    required this.id,
    required this.userName,
    required this.gender,
    required this.email,
  });

  // to Json
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'userName': userName,
        'gender': gender,
        'email': email,
      };
}

const String _genderKey = 'GENDER_KEY';
const String _userNameKey = 'USER_NAME_KEY';
const String _emailKey = 'EMAIL_KEY';
const String _actionKey = 'ACTION_KEY';

List<DataTableReorderableColumn<DemoDataTableModel>> _columnsDemoDataTable = [
  DataTableReorderableColumn(
    key: _genderKey,
    name: 'Gender',
    minWidth: 100,
    customizeItemWidget: (
      context,
      value,
      rowData,
      columnKey,
      columnName,
      width,
      showOnScreens,
    ) {
      return Align(
        alignment: Alignment.center,
        child: rowData.gender == 'male'
            ? TekTags.success(
                'Male',
                isOutlined: true,
              )
            : TekTags.failure(
                'Female',
                isOutlined: true,
              ),
      );
    },
  ),
  DataTableReorderableColumn(
    key: _userNameKey,
    name: 'User name',
    minWidth: 200,
    flex: 2,
    customizeItemWidget: (
        context,
        value,
        rowData,
        columnKey,
        columnName,
        width,
        showOnScreens,
        ) {
      return Align(
        alignment: Alignment.center,
        child: TekTypography(
          text: rowData.userName,
          fontWeight: FontWeight.w600,
        ),
      );
    },
  ),
  DataTableReorderableColumn(
    key: _emailKey,
    name: 'Email',
    minWidth: 200,
    flex: 2,
    customizeItemWidget: (
      context,
      value,
      rowData,
      columnKey,
      columnName,
      width,
      showOnScreens,
    ) {
      return Align(
        alignment: Alignment.center,
        child: Text(
          rowData.email,
        ),
      );
    },
  ),
  DataTableReorderableColumn(
    key: _actionKey,
    name: 'Action',
    minWidth: 120,
    customizeItemWidget: (
      context,
      value,
      rowData,
      columnKey,
      columnName,
      width,
      showOnScreens,
    ) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TekLink(
            text: 'Edit',
            onPressed: () {},
            size: TekLinkSize.medium,
          ),
          TekHSpace.mainSpace,
          TekLink(
            text: 'Delete',
            onPressed: () {},
            size: TekLinkSize.medium,
          ),
        ],
      );
    },
  ),
];

const List<DemoDataTableModel> _dataSourcesDemoDataTable = [
  DemoDataTableModel(
    id: 1,
    userName: 'Name of user 1',
    gender: 'male',
    email: 'jerry.ward@example.com',
  ),
  DemoDataTableModel(
    id: 2,
    userName: 'Name of user 2',
    gender: 'female',
    email: 'cariana.sales@example.com',
  ),
  DemoDataTableModel(
    id: 3,
    userName: 'Name of user 3',
    gender: 'male',
    email: 'kenzo.gautier@example.com',
  ),
  DemoDataTableModel(
    id: 4,
    userName: 'Name of user 4',
    gender: 'male',
    email: 'arnoldo.toro@example.com',
  ),
  DemoDataTableModel(
    id: 5,
    userName: 'Name of user 5',
    gender: 'female',
    email: 'claudia.velasco@example.com',
  ),
  DemoDataTableModel(
    id: 6,
    userName: 'Name of user 6',
    gender: 'male',
    email: 'taahira.salian@example.com',
  ),
  DemoDataTableModel(
    id: 7,
    userName: 'Name of user 7',
    gender: 'female',
    email: 'sophie.levesque@example.com',
  ),
  DemoDataTableModel(
    id: 8,
    userName: 'Name of user 8',
    gender: 'female',
    email: 'angela.gomez@example.com',
  ),
  DemoDataTableModel(
    id: 9,
    userName: 'Name of user 9',
    gender: 'male',
    email: 'taahira.salian@example.com',
  ),
  DemoDataTableModel(
    id: 10,
    userName: 'Name of user 10',
    gender: 'female',
    email: 'sophie.levesque@example.com',
  ),
  DemoDataTableModel(
    id: 11,
    userName: 'Name of user 11',
    gender: 'female',
    email: 'angela.gomez@example.com',
  ),
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TekDataTableReorderableController<DemoDataTableModel> _controller =
      TekDataTableReorderableController<DemoDataTableModel>();

  @override
  void initState() {
    super.initState();
    _controller.initDataTableState(
      dataSources: _dataSourcesDemoDataTable,
    );
  }

  void _handleChangeData({
    required int currentPage,
    required int itemsPerPage,
  }) {
    TekLogger.debugLog({
      'currentPage': currentPage,
      'itemsPerPage': itemsPerPage,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Test Reorderable Table',
          style: context.theme.appBarTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(TekSpacings().mainSpacing),
        child: TekDataTableReorderable<DemoDataTableModel>(
          tableColumns: _columnsDemoDataTable,
          controller: _controller,
          handleChangeData: _handleChangeData,
          rowOption: TekDataTableReorderableRowOption(
            paddingOfRowItem: EdgeInsets.all(TekSpacings().mainSpacing),
          ),
          onReorder: (oldIndex, newIndex){
            _controller.reorderRow(oldIndex, newIndex);
          },
        ),
      ),
    );
  }
}
