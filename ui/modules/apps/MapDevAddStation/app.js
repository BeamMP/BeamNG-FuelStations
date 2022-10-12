//MapDevAddStation has been started by Sky777, part of the FuelStations Team, adding Fuel Stations to BeamNG maps!.

angular.module('beamng.apps')

.directive('addStation', function () {
    return {
    templateUrl: '/ui/modules/apps/MapDevAddStation/app.html',
    replace: true,
    restrict: 'EA',
    }
})