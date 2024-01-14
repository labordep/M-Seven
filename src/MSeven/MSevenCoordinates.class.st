Class {
	#name : #MSevenCoordinates,
	#superclass : #Object,
	#instVars : [
		'position',
		'tilt'
	],
	#category : #'MSeven-Model'
}

{ #category : #initialization }
MSevenCoordinates >> initialize [ 

	super initialize.
	self position: BlPoint3D new.
	self tilt: BlVector3D zero.
]

{ #category : #accessing }
MSevenCoordinates >> pitch [

	^ self tilt z
]

{ #category : #accessing }
MSevenCoordinates >> pitch: anAngle [

	self tilt z: anAngle
]

{ #category : #accessing }
MSevenCoordinates >> position [

	^ position ifNil:[ position := BlPoint3D new ]
]

{ #category : #accessing }
MSevenCoordinates >> position: aBlPoint3D [

	position := aBlPoint3D
]

{ #category : #accessing }
MSevenCoordinates >> roll [

	^ self tilt x
]

{ #category : #accessing }
MSevenCoordinates >> roll: anAngle [

	self tilt x: anAngle
]

{ #category : #accessing }
MSevenCoordinates >> tilt [

	^ tilt ifNil:[ tilt := BlVector3D new ]
]

{ #category : #accessing }
MSevenCoordinates >> tilt: aBlVector3D [

	tilt := aBlVector3D
]

{ #category : #accessing }
MSevenCoordinates >> yaw [

	^ self tilt y
]

{ #category : #accessing }
MSevenCoordinates >> yaw: anAngle [

	self tilt y: anAngle


]
