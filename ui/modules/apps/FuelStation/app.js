var app = angular.module('beamng.apps');
app.directive('fuelstation', ['UiUnits', function (UiUnits) {
	return {
		templateUrl: 'modules/apps/FuelStation/app.html',
		replace: true,
		restrict: 'EA',
		scope: true
	}
}]);
app.controller("fuelstation", ['$scope', 'bngApi', '$interval', function ($scope, bngApi, $interval) {
	$scope.init = function() {

	};

	$scope.reset = function() {
		$scope.init();
	};

	$scope.select = function() {
		bngApi.engineLua('setCEFFocus(true)');
	};

	var promise;
	$scope.addFuel = function() {
		if(promise){
			$interval.cancel(promise);
		}
		promise = $interval(function () {
			var v = document.querySelector('#FuelValueIncreasedBy').value;
			document.querySelector('#FuelValueIncreasedBy').value = parseFloat(v) + 0.1;
			bngApi.engineLua('fuelStations.addFuel(true)');
		}, 100);

	};

	$scope.stopAddFuel = function () {
		$interval.cancel(promise);
		promise = null;
	};
}]);

function fuelUIShowHide(b, t) {
	//console.log("fuelUIShowHide("+b+")")
	if (b == "true") {
		if (document.querySelector('#fuelstation').style.display == "none") {
			document.querySelector('#fuelstation').style.display = "block";
			document.querySelector('#FuelValueIncreasedBy').value = 0.0;
			if (t == "EV") {
				document.querySelector('#EVNote').style.display = "";
				document.querySelector('#GasNote').style.display = "none";
				document.querySelector('#FuelNote').style.display = "none";
				document.querySelector('#ActionButton').innerHTML = "Charge";
			} else {
				document.querySelector('#GasNote').style.display = "";
				document.querySelector('#EVNote').style.display = "none";
				document.querySelector('#FuelNote').style.display = "";
				document.querySelector('#ActionButton').innerHTML = "Fuel";
			}
		}
	} else if (b == "false") {
		document.querySelector('#fuelstation').style.display = "none";
	}
}
