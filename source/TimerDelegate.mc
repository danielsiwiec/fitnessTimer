using Toybox.WatchUi as Ui;

class TimerDelegate extends Ui.BehaviorDelegate {

	hidden var model;
	hidden var started = false;

  function initialize(mdl) {
  	model = mdl;
    BehaviorDelegate.initialize();
  }

	function onSelect() {
		model.start();
		started = true;
		return true;
	}

	function onBack() {
		model.dropSession();
		Toybox.System.exit();
	}
}
