import 'package:customerapp/features/request/data/repositories/request-repositories-implementation.dart';
import 'package:customerapp/features/request/presentation/bloc/request-events.dart';
import 'package:customerapp/features/request/presentation/bloc/request-state.dart';
import 'package:customerapp/features/trips/data/repositories/trips-repository-implementation.dart';
import 'package:customerapp/features/trips/presentation/bloc/trip-events.dart';
import 'package:customerapp/features/trips/presentation/bloc/trip-state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TripBloc extends Bloc<BaseTripEvent, BaseTripState> {
  TripBloc(BaseTripState initialState) : super(initialState);

  @override
  Stream<BaseTripState> mapEventToState(BaseTripEvent event) async* {

    TripRepositoryImplementation repo = new TripRepositoryImplementation();

    if(event is GetTripEvent){
      yield TripLoadingState();
      final result = await repo.getTripsData();

      if(result.hasDataOnly){
        yield TripSuccessState(trips:result.data);
      }else{
        yield TripFailedState(result.error);
      }

    }
  }
}
