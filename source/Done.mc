using Toybox.WatchUi as Ui;

class DoneView extends Ui.View{

	function initialize() {
    View.initialize();
  }

	function onLayout(dc) {
		setLayout(Rez.Layouts.DoneLayout(dc));
	}
}

class DoneDelegate extends Ui.BehaviorDelegate {

	function initialize() {
    BehaviorDelegate.initialize();
  }

	function onBack() {
		Toybox.System.exit();
	}
}
