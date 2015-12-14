package;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import openfl.Assets;

import Math;

class Main extends Sprite {
	private var Square:Sprite;
	private var Image:Bitmap;

	private var left:Bool;
	private var right:Bool;

	private var rotationSpeed:Int;
	private var moveSpeed:Int;

	public function new() {
		super();

		Square = new Sprite();
		Square.x = stage.stageWidth/2;
		Square.y = stage.stageHeight/2;

		Image = new Bitmap(Assets.getBitmapData("assets/sprite_multicolor.png"));
		Image.x = -(Image.width)/2;
		Image.y = -(Image.height)/2;

		Square.addChild(Image);
		addChild(Square);

		stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_onKeyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, stage_onKeyUp);
		stage.addEventListener(Event.ENTER_FRAME, this_onEnterFrame);

		rotationSpeed = 2;
		moveSpeed = 3;
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
			Square.rotation += -1*rotationSpeed;
		}
		if(right) {
			Square.rotation += rotationSpeed;
		}

		var radians:Float = Square.rotation*(Math.PI/180);
		Square.y += moveSpeed*Math.sin(radians);
		Square.x += moveSpeed*Math.cos(radians);
	}
}