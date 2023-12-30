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
MSevenPOC5 >> createWorldObjects [

	| pharo |
	pharo := MSevenWorldEntity new.
	pharo sprite: (self iconNamed: #pharo).
	
	self world actors add: pharo
]

{ #category : #initialization }
MSevenPOC5 >> initialize [ 

	super initialize.
	
	defaultViewResolution := 256@192.
	defaultWindowSize := 400@300.
	
	self initializeWorld.
	self initializeCamera.
	self initializeView.
	
	self createWorldObjects.
	
	space := self view openInSpace.
	"Install events listener"
	space addEventHandler: (BlEventHandler
			 on: BlSpaceResizedEvent
			 do: [ :e | self view resolution: self computeViewResolution ])
]

{ #category : #initialization }
MSevenPOC5 >> initializeCamera [
	
	camera := MSevenCamera new.
	camera fieldOfView: 250.
	camera coordinates z: 1.0.
]

{ #category : #initialization }
MSevenPOC5 >> initializeView [

	view := MSevenWorldCameraViewBlElement new.
	view camera: self camera.
	view resolution: self computeViewResolution.
]

{ #category : #initialization }
MSevenPOC5 >> initializeWorld [

	world := MSevenWorld new.
]

{ #category : #accessing }
MSevenPOC5 >> view [

	^ view
]

{ #category : #accessing }
MSevenPOC5 >> world [

	^ world
]
