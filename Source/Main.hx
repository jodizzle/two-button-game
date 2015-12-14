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
	private var Square2:Sprite;
	private var Image:Bitmap;
	private var Image2:Bitmap;
	private var gameContainer:Sprite;

	private var left:Bool;
	private var right:Bool;

	private var rotationSpeed:Int;
	private var moveSpeed:Int;

	public function new() {
		super();

		Square = new Sprite();
		Square.x = stage.stageWidth/2;
		Square.y = stage.stageHeight/2;
		Square2 = new Sprite();
		Square2.x = 100;
		Square2.y = 100;

		Image = new Bitmap(Assets.getBitmapData("assets/sprite_multicolor.png"));
		Image.x = -(Image.width)/2;
		Image.y = -(Image.height)/2;
		Image2 = new Bitmap(Assets.getBitmapData("assets/sprite.png"));
		Image.x = -(Image2.width)/2;
		Image.y = -(Image2.height)/2;

		//All game objects with become children of gameContainer, which will then become
		//a child of Main
		gameContainer = new Sprite();

		Square.addChild(Image);
		Square2.addChild(Image2);
		gameContainer.addChild(Square);
		gameContainer.addChild(Square2);
		addChild(gameContainer);

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

		//displayObjectContainer.rotation is in degrees, need to convert to radians for Math.sin and Math.cos
		var radians:Float = Square.rotation*(Math.PI/180);
		Square.y += moveSpeed*Math.sin(radians);
		Square.x += moveSpeed*Math.cos(radians);

		//Transform gameContainer so that it offsets Square transformations and keeps Square centered on the stage
		gameContainer.x = -Square.x + stage.stageWidth/2;
		gameContainer.y = -Square.y + stage.stageHeight/2;
	}
}