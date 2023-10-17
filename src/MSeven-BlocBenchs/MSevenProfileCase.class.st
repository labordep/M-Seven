"
I am a profile case for MSevenPOC3.
"
Class {
	#name : #MSevenProfileCase,
	#superclass : #BlFixedDurationProfileCase,
	#instVars : [
		'spaceExtentFactor',
		'viewResolution'
	],
	#category : #'MSeven-BlocBenchs'
}

{ #category : #examples }
MSevenProfileCase class >> exampleFPS [

	[ 	| case |
		case := MSevenProfileCase new
			hostClass: BlOSWindowSDL2Host;
			duration: 10 seconds;
			yourself.

		(BlProfileRunner newForCase: case)
			enableFPS;
			run;
			openMeterReports ] fork
]

{ #category : #examples }
MSevenProfileCase class >> exampleProfile [

	[ 	| case |
		case := MSevenProfileCase new
			hostClass: BlOSWindowSDL2Host;
			duration: 5 seconds;
			yourself.

		(BlProfileRunner newForCase: case)
			enableASProfiler;
			run;
			openMeterReports ] fork
]

{ #category : #initialization }
MSevenProfileCase >> initialize [

	super initialize.
	
	viewResolution := 256 @ 240.
	spaceExtentFactor := 1
]

{ #category : #printing }
MSevenProfileCase >> label [

	^ 'MSeven'
]

{ #category : #hooks }
MSevenProfileCase >> newElement [
	"Answer the element under study."

	| view position angle |
	view := MSevenPOC3 view materializeAsBlElement first.
	view
		map: MSevenResources checkerboardTexture
		cameraResolution: self viewResolution.

	position := 0@0.
	view enqueueTask:
		(BlNumberTransition new
			from: 0; to: 1;
			onStepDo: [ :t |
				position := position + (0.01 @ 0).
				angle := (position x * 0.3) sin.
				view
					cameraPosition: position
					cameraAngle: angle ];
			beInfinite;
			yourself).

	^ view
]

{ #category : #hooks }
MSevenProfileCase >> spaceExtent [

	^ (self viewResolution * spaceExtentFactor) asIntegerPoint + 10 asPoint
]

{ #category : #accessing }
MSevenProfileCase >> spaceExtentFactor [

	^ spaceExtentFactor
]

{ #category : #accessing }
MSevenProfileCase >> spaceExtentFactor: aPositiveInteger [

	spaceExtentFactor := aPositiveInteger
]

{ #category : #accessing }
MSevenProfileCase >> viewResolution [

	^ viewResolution
]

{ #category : #accessing }
MSevenProfileCase >> viewResolution: aPoint [

	viewResolution := aPoint
]
