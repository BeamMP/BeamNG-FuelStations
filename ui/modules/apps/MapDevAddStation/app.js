//MapDevAddStation has been started by Sky777, part of the FuelStations Team, adding Fuel Stations to BeamNG maps!.

angular.module('beamng.apps')

.directive('addStation', ['StreamsManager', function(StreamsManager) {
    return {
        templateUrl: '/ui/modules/apps/MapDevAddStation/app.html',
        replace: true,
        restrict: 'EA',
        link: function(scope, element, attrs) {
            //Optional list of streams used in app
            var streamsList=[/*Streams here*/];
            //Make needed streams available
            StreamsManager.add(streamsList);
            //Clean up after closing app
            scope.$on('$destroy', function(){
                StreamsManager.remove(streamsList);
            }
            );
            scope.$on('streamsUpdate', function(event, streams){
                //Code using streams' values
            }
            );
        }
    };
}]);