Class {
	#name : #MSevenProfileCase,
	#superclass : #BlFixedDurationProfileCase,
	#category : #'MSeven-BlocBenchs'
}

{ #category : #examples }
MSevenProfileCase class >> example [

	[ 	| case |
		case := MSevenProfileCase new
			hostClass: BlOSWindowSDL2Host;
			duration: 7 seconds;
			yourself.

		(BlProfileRunner newForCase: case)
			enableFPS;
			run;
			openMeterReports ] fork
]

{ #category : #printing }
MSevenProfileCase >> label [

	^ 'MSeven'
]

{ #category : #hooks }
MSevenProfileCase >> newElement [
	"Answer the element under study."

	| viewResolution view position angle |
	viewResolution := 256 @ 240.
	view := MSevenPOC3 view materializeAsBlElement first.
	view
		map: MSevenResources checkerboardTexture
		cameraResolution: viewResolution.

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
