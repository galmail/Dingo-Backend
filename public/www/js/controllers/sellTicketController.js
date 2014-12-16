/**
 * Sell Ticket controller.
 *
 */

dingo.controllers.controller('SellTicketCtrl', function($scope, Event) {

	
	$scope.selectedEvent = {
		// id: '1',
		// name: 'Super Event 1',
		// location: 'London city',
		// from: '01/02/2015',
		// to: '02/02/2015'
	};
	$scope.events = [];

	$scope.filterEvent = function(){
		var self = this;
		if(self.selectedEvent.name.length>0) {
			console.log('filtering event: ' + self.selectedEvent.name);
			self.selectedEvent.selected = false;
			Event.searchByName(self.selectedEvent.name, function(listOfEvents){
				self.events = listOfEvents;
			});
		}
	};

	$scope.showEvent = function(event){
		var thisEvent = event.name.toLowerCase();
		var selectedEvent = this.selectedEvent.name.toLowerCase();
		return (thisEvent.indexOf(selectedEvent)>=0 && thisEvent != selectedEvent && selectedEvent.length>0);
	};

	$scope.selectEvent = function(event,events){
		var self = this;
		console.log('selecting event: ' + event.name);
		this.selectedEvent.name = event.name;
		this.selectedEvent.location = event.location;
		this.selectedEvent.from = event.from;
		this.selectedEvent.to = event.to;
		this.selectedEvent.selected = true;
		// set location, from, to fields to disabled.



	};
	

});
