Class {
	#name : #MSevenPOC5,
	#superclass : #Object,
	#instVars : [
		'camera',
		'cameraSpeed',
		'view',
		'world',
		'defaultViewResolution',
		'defaultWindowSize',
		'space'
	],
	#category : #'MSeven-POCwithModel'
}

{ #category : #accessing }
MSevenPOC5 class >> start [
	<script>
	
	self new.
]

{ #category : #events }
MSevenPOC5 >> addSpaceEventHandlers [

	"Install events listener"
	space addEventHandler: (BlEventHandler
			 on: BlSpaceResizedEvent
			 do: [ :e | self view resolution: self computeViewResolution ])
]

{ #category : #accessing }
MSevenPOC5 >> camera [

	^ camera
]

{ #category : #accessing }
MSevenPOC5 >> cameraSpeed [

	^ cameraSpeed ifNil: [ cameraSpeed := 0.5 ]
]

{ #category : #accessing }
MSevenPOC5 >> cameraSpeed: anObject [

	cameraSpeed := anObject
]

{ #category : #computing }
MSevenPOC5 >> computeViewResolution [
	"Compute the world resolution to have correct ratio depending size of the application window to be in fullsize"

	"resolution for ratio 4/3"
	| windowSize ratio newWidth newResolution newHeight |
	
	"get actual window size"
	windowSize := space ifNil:[ defaultWindowSize ] ifNotNil:[ :s | s windowExtent ].
	(windowSize x = 0 or:[ windowSize y = 0 ]) ifTrue:[ windowSize := defaultWindowSize ].
	
	"compute balance between preserving world resoltuion ratio and pixels size"
	ratio := windowSize x / windowSize y.
	ratio >= 1 ifTrue:[ 
		"more larger than heighter" 
		newWidth := windowSize x * defaultViewResolution y / windowSize y.
		newResolution := newWidth @ defaultViewResolution y.
	] ifFalse:[
		"more heighter than larger"
		newHeight := windowSize y * defaultViewResolution x / windowSize x.
		newResolution := defaultViewResolution x @ newHeight.
	].

	^ newResolution rounded
]

{ #category : #initialization }
MSevenPOC5 >> createWorldActors [

	| pharoActor sharedTexture |
	sharedTexture := MSevenResources actor_pharo.
	
	pharoActor := MSevenWorldActor new.
	pharoActor name: 'pharo'.
	pharoActor sprite: (MSevenSprite new texture: sharedTexture).
	self world addActor: pharoActor.
	
	pharoActor := MSevenWorldActor new.
	pharoActor name: 'pharo'.
	pharoActor pose x: 1000.
	pharoActor sprite: (MSevenSprite new texture: sharedTexture).
	self world addActor: pharoActor.
	
	pharoActor := MSevenWorldActor new.
	pharoActor name: 'pharo'.
	pharoActor pose y: 1000.
	pharoActor sprite: (MSevenSprite new texture: sharedTexture).
	self world addActor: pharoActor.
	
	pharoActor := MSevenWorldActor new.
	pharoActor name: 'pharo'.
	pharoActor pose x: 1000.
	pharoActor pose y: 1000.
	pharoActor sprite: (MSevenSprite new texture: sharedTexture).
	self world addActor: pharoActor.
]

{ #category : #initialization }
MSevenPOC5 >> createWorldLayers [

	| layer sprite |

	"ground"
	sprite := MSevenAnimatedSprite new.
	sprite addTexture: MSevenResources ground_pharo_step1.
	sprite addTexture: MSevenResources ground_pharo_step2.
	sprite addTexture: MSevenResources ground_pharo_step3.

	layer := MSevenWorldGroundLayer new.
	layer name: 'Ground'.
	layer sprite: sprite.
	layer scale: 50.
	self world addLayer: layer.

	"sky"	
	sprite := MSevenSprite new.
	sprite texture: MSevenResources sky_pharo.
	
	layer := MSevenWorldSkyLayer new.
	layer name: 'Sky'.
	layer sprite: sprite.
	self world addLayer: layer.
]

{ #category : #initialization }
MSevenPOC5 >> initialize [ 

	super initialize.
	
	defaultViewResolution := 256@192.
	defaultWindowSize := 400@300.
	
	self initializeWorld.
	self initializeCamera.
	self initializeView.
	
	self createWorldLayers.
	self createWorldActors.
	
	self initializeSpace.
	self installSpaceHandlers.
]

{ #category : #initialization }
MSevenPOC5 >> initializeCamera [
	
	camera := MSevenCamera new.
	camera fieldOfView: 250.
	camera pose position x: 0 y: 0 z: 0.0.
]

{ #category : #initialization }
MSevenPOC5 >> initializeSpace [

	self view constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	space := self view openInSpace.
	space title: 'M-SEVEN Proof Of Concept 5'.
	self addSpaceEventHandlers.

]

{ #category : #initialization }
MSevenPOC5 >> initializeView [

	| transition |
	view := MSevenWorldCameraViewBlElement new.
	view camera: self camera.
	view resolution: self computeViewResolution.
	view world: self world.
	
	"Setup a transition to update the view at each frames"
	transition := BlNumberTransition new 
		from: 0; 
		to: 1; 
		onStepDo: [ :e | self updateCameraView: view step: e ]; 
		beInfinite; 
		yourself.	
			
	view enqueueTask: transition.
]

{ #category : #initialization }
MSevenPOC5 >> initializeWorld [

	world := MSevenWorld new.
]

{ #category : #events }
MSevenPOC5 >> installSpaceHandlers [

	space addEventHandler: (BlEventHandler
			 on: BlKeyDownEvent
			 do: [ :e | self receiveKeyDownEvent: e ]).
			
	space addEventHandler: (BlEventHandler
			 on: BlKeyUpEvent
			 do: [ :e | self receiveKeyUpEvent: e ])
]

{ #category : #'private - events' }
MSevenPOC5 >> moveBackwardCamera [

	| newPose |
	newPose := MSevenPoseUtils
		                  moveBackwardPose: self camera pose
		                  speed: self cameraSpeed.
	
	self camera pose: newPose
]

{ #category : #'private - events' }
MSevenPOC5 >> moveDownCamera [

	| newPose |
	newPose := MSevenPoseUtils
		                  moveDownPose: self camera pose
		                  speed: self cameraSpeed.
	
	self camera pose: newPose
]

{ #category : #'private - events' }
MSevenPOC5 >> moveForwardCamera [

	| newPose |
	newPose := MSevenPoseUtils
		                  moveForwardPose: self camera pose
		                  speed: self cameraSpeed.
		
	self camera pose: newPose
]

{ #category : #'private - events' }
MSevenPOC5 >> moveUpCamera [

	| newPose |
	newPose := MSevenPoseUtils
		                  moveUpPose: self camera pose
		                  speed: self cameraSpeed.
	
	self camera pose: newPose
]

{ #category : #events }
MSevenPOC5 >> receiveKeyDownEvent: anEvent [
	"Set the key down actions to move the camera"

	"LTBR Arrow or ZQSD/WASD for azerty/qwerty keyboard"
	(anEvent key isArrowUp or: [
		 anEvent key = KeyboardKey Z or: [ anEvent key = KeyboardKey W ] ])
		ifTrue: [
			self moveForwardCamera.
			^ self ].

	(anEvent key isArrowDown or: [ anEvent key = KeyboardKey S ])
		ifTrue: [
			self moveBackwardCamera.
			^ self ].
		
	(anEvent key isArrowLeft or: [
		 anEvent key = KeyboardKey Q or: [ anEvent key = KeyboardKey A ] ]) ifTrue:[
		self turnLeftCamera.
		^self	
	].

	(anEvent key isArrowRight or: [
		 anEvent key = KeyboardKey D ]) ifTrue:[
		self turnRightCamera.
		^self	
	].

	"Altitude management : R/F"
	(anEvent key = (KeyboardKey R)) ifTrue:[
		self moveUpCamera.
		^self	
	]. 

	(anEvent key = (KeyboardKey F)) ifTrue:[
		self moveDownCamera.
		^self	
	]. 
]

{ #category : #events }
MSevenPOC5 >> receiveKeyUpEvent: anEvent [
]

{ #category : #'private - events' }
MSevenPOC5 >> turnLeftCamera [

	| newPose |
	newPose := MSevenPoseUtils
		                  turnLeftPose: self camera pose
		                  angle: 5 degreesToRadians.
		
	self camera pose: newPose 
]

{ #category : #'private - events' }
MSevenPOC5 >> turnRightCamera [

	| newPose |
	newPose := MSevenPoseUtils
		                  turnRightPose: self camera pose
		                  angle: 5 degreesToRadians. 
		
	self camera pose: newPose
]

{ #category : #updating }
MSevenPOC5 >> updateCameraView: aCameraViewElement step: aNumber [

	aCameraViewElement invalidate.
]

{ #category : #accessing }
MSevenPOC5 >> view [

	^ view
]

{ #category : #accessing }
MSevenPOC5 >> world [

	^ world
]
