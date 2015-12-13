package;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import openfl.Assets;

class Main extends Sprite {
	private var Square:Sprite;

	private var left:Bool;
	private var right:Bool;

	public function new() {
		super();

		Square = new Sprite();
		Square.addChild(new Bitmap(Assets.getBitmapData("assets/sprite.png")));
		Square.x = stage.stageWidth/2;
		Square.y = stage.stageHeight/2;
		addChild(Square);

		stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_onKeyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, stage_onKeyUp);
		stage.addEventListener(Event.ENTER_FRAME, this_onEnterFrame);
	}

	private function stage_onKeyDown(event:KeyboardEvent):Void {
		switch(event.keyCode) {
			case Keyboard.LEFT: left = true;
			case Keyboard.RIGHT: right = true;
		}
	}

	private function stage_onKeyUp(event:KeyboardEvent):Void {
		switch(event.keyCode) {
			case Keyboard.LEFT: left = false;
			case Keyboard.RIGHT: right = false;
		}
	}

	private function this_onEnterFrame(event:Event):Void {
		if(left) {
			Square.rotation += -5;
		}
		if(right) {
			Square.rotation += 5;
		}
	}
}