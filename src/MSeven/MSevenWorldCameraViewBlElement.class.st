Class {
	#name : #MSevenWorldCameraViewBlElement,
	#superclass : #BlElement,
	#instVars : [
		'camera',
		'resolution',
		'world',
		'environmentSurface',
		'scaleFactor',
		'environmentSurfacePattern'
	],
	#category : #'MSeven-View'
}

{ #category : #drawing }
MSevenWorldCameraViewBlElement >> aeDrawGeometryOn: aeCanvas [
	"Ignore geometry and other visual properties and directly show a fresh camera surface."
	
	environmentSurfacePattern ifNil:[ ^ self ].
	
	"draw environment surface"
	self updateEnvironmentSurface.
	
	self aeDrawWorldEnvironmentOn: aeCanvas.
]

{ #category : #drawing }
MSevenWorldCameraViewBlElement >> aeDrawWorldEnvironmentOn: aeCanvas [
	
	aeCanvas privateAeCairoContext source: environmentSurfacePattern; rectangleTo: self size; fill
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> camera [

	^ camera
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> camera: anObject [

	camera := anObject
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> environmentSurface [

	^ environmentSurface
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> environmentSurface: anObject [

	environmentSurface := anObject
]

{ #category : #initialization }
MSevenWorldCameraViewBlElement >> initialize [

	super initialize.
	self initializeEnvironmentSurface.
	
]

{ #category : #initialization }
MSevenWorldCameraViewBlElement >> initializeEnvironmentSurface [

	self resolution ifNil:[ ^ self ].

	environmentSurface := AeCairoImageSurface extent: self resolution format: AeCairoSurfaceFormat argb32.
	environmentSurfacePattern := AeCairoSurfacePattern surface: environmentSurface.
	environmentSurfacePattern filter: AeCairoSamplingFilter nearest.
]

{ #category : #initialization }
MSevenWorldCameraViewBlElement >> prepareWorld [

	
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> resolution [

	^ resolution
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> resolution: anObject [

	resolution = anObject ifTrue:[ ^ self ].
	resolution := anObject.
	self initializeEnvironmentSurface.
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> scaleFactor [

	^ scaleFactor ifNil:[ scaleFactor := 1.0 ]
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> scaleFactor: aFloat [

	scaleFactor = aFloat ifTrue:[ ^ self ].
	scaleFactor := aFloat.
	self updatePattern.
]

{ #category : #initialization }
MSevenWorldCameraViewBlElement >> size: aPoint [

	| newScale |
	super size: aPoint.
	
	self resolution ifNil:[ ^ self ].
	
	"update scale factor"
	newScale := (self size / self resolution).
	newScale := (newScale x < newScale y ifTrue:[ newScale x ] ifFalse:[ newScale y ]).
	self scaleFactor: newScale.
]

{ #category : #update }
MSevenWorldCameraViewBlElement >> updateEnvironmentSurface [

	
]

{ #category : #initialization }
MSevenWorldCameraViewBlElement >> updatePattern [
	
	environmentSurfacePattern ifNil:[ ^ self ].
	self scaleFactor ifNil:[ ^ self ].

	"By default, patterns have the identity matrix.
	Then, we will only change it if really needed."
	(scaleFactor closeTo: 1.0) ifFalse: [
		environmentSurfacePattern matrix: (AeCairoMatrix	newScalingByX: (1.0 / self scaleFactor) y: (1.0 / self scaleFactor))
	]
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> world [

	^ world
]

{ #category : #accessing }
MSevenWorldCameraViewBlElement >> world: anObject [

	world = anObject ifTrue:[ ^ self ].
	world := anObject.
	self prepareWorld.
]
