Class {
	#name : #MSevenPOC5,
	#superclass : #Object,
	#instVars : [
		'camera',
		'view',
		'world',
		'defaultViewResolution',
		'defaultWindowSize',
		'space'
	],
	#category : #'MSeven-POCv2'
}

{ #category : #accessing }
MSevenPOC5 class >> start [
	<script>
	
	self new.
]

{ #category : #initialization }
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

	| pharoActor |
	pharoActor := MSevenWorldActor new.
	pharoActor sprite: (self iconNamed: #pharo).
	
	self world addActor: pharoActor
]

{ #category : #initialization }
MSevenPOC5 >> createWorldLayers [

	| layer |
	layer := MSevenWorldLayer new.
	layer texture: MSevenResources pharoTexture.
	self world addLayer: layer
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
]

{ #category : #initialization }
MSevenPOC5 >> initializeCamera [
	
	camera := MSevenCamera new.
	camera fieldOfView: 250.
	camera coordinates position x: 0 y: 0 z: 1.0.
]

{ #category : #initialization }
MSevenPOC5 >> initializeSpace [

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
	
	view constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
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
