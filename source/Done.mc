using Toybox.WatchUi as Ui;

class DoneView extends Ui.View{

	function initialize() {
    View.initialize();
  }

	function onLayout(dc) {
		setLayout(Rez.Layouts.DoneLayout(dc));
	}
}
