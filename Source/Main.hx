package;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import openfl.Assets;

import Math;

class Main extends Sprite {
	private var square:Sprite;
	private var square2:Sprite;
	private var image:Bitmap;
	private var image2:Bitmap;
	private var gameContainer:Sprite;
	private var trailContainer:Sprite;
	//List for square trail
	private var trail:Array<Sprite>;

	private var left:Bool;
	private var right:Bool;

	private var rotationSpeed:Int;
	private var moveSpeed:Int;

	public function new() {
		super();

		square = new Sprite();
		square.x = stage.stageWidth/2;
		square.y = stage.stageHeight/2;
		square2 = new Sprite();
		square2.x = 100;
		square2.y = 100;

		image = new Bitmap(Assets.getBitmapData("assets/sprite_multicolor.png"));
		image.x = -(image.width)/2;
		image.y = -(image.height)/2;
		image2 = new Bitmap(Assets.getBitmapData("assets/sprite.png"));
		image.x = -(image2.width)/2;
		image.y = -(image2.height)/2;

		//All game objects with become children of gameContainer, which will then become
		//a child of Main
		gameContainer = new Sprite();
		//Contains the trail left behind by the square.  Separated from the gameContainer so
		//that trails can be properly drawn beneath the square and the other game objects.
		trailContainer = new Sprite();

		addChild(trailContainer);

		square.addChild(image);
		square2.addChild(image2);
		gameContainer.addChild(square);
		gameContainer.addChild(square2);
		addChild(gameContainer);

		stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_onKeyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, stage_onKeyUp);
		stage.addEventListener(Event.ENTER_FRAME, this_onEnterFrame);

		trail = new Array<Sprite>();
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
			square.rotation += -1*rotationSpeed;
		}
		if(right) {
			square.rotation += rotationSpeed;
		}

		//displayObjectContainer.rotation is in degrees, need to convert to radians for Math.sin and Math.cos
		var radians:Float = square.rotation*(Math.PI/180);
		square.y += moveSpeed*Math.sin(radians);
		square.x += moveSpeed*Math.cos(radians);

		//Transform gameContainer so that it offsets square transformations and keeps square centered on the stage
		gameContainer.x = -square.x + stage.stageWidth/2;
		gameContainer.y = -square.y + stage.stageHeight/2;

		//Add to trail left behind by square
		//TODO: some of the trail pieces seem to end up slightly off-rotation from the square...
		var t:Sprite = new Sprite();
		t.x = square.x;
		t.y = square.y;
		t.rotation = square.rotation;

		var t_image = new Bitmap(Assets.getBitmapData("assets/sprite_green.png"));
		t_image.x = -(t_image.width)/2;
		t_image.y = -(t_image.height)/2;
		t.addChild(t_image);

		trail.push(t);

		//Offset to center most recent trail piece
		trailContainer.x = -t.x + stage.stageWidth/2;
		trailContainer.y = -t.y + stage.stageHeight/2;
		
		trailContainer.addChild(t);
	}
}