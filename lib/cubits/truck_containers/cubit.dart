import 'package:barcode_scanner/models/container.dart';
import 'package:barcode_scanner/models/truck.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'state.dart';
part 'data_provider.dart';

class DataCubit extends Cubit<DataState> {
  static DataCubit cubit(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<DataCubit>(context, listen: listen);
  DataCubit() : super(TrucksLoading());
  final dataProvider = TrucksDataProvider();
  Future<Truck?> getAllTruckData() async {
    emit(TrucksLoading());
    try {
      List<Truck?> trucks = await dataProvider.getAllTrucks();
      emit(TrucksLoadSuccess(trucks: trucks));
    } catch (e) {
      print("ERROR LOADING TRUCKS");
      emit(TrucksLoadFailure(errorMessage: e.toString()));
    }
  }

  Future<int?> getTotalContainerCount() async {
    emit(ContainersCountLoading());
    try {
      int count = await dataProvider.getTotalContainerCounts();
      emit(ContainersCountLoadSuccess(count: count));
    } catch (e) {
      emit(ContainersCountLoadFailure(errorMessage: e.toString()));
    }
  }
}
