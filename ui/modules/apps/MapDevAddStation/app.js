//MapDevAddStation has been started by Sky777, part of the FuelStations Team, 
//making it easy to add Fuel Stations to BeamNG maps!

angular.module('beamng.apps')

.directive('addStation', ['StreamsManager', function(StreamsManager) {
    return {
        template:
        '<object style="width:100%; height:100%;" type="image/svg+xml" data="/ui/modules/apps/MapDevAddStation/tool.svg"></object>',
        replace: true,
        restrict: 'EA',
        scope: true,
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