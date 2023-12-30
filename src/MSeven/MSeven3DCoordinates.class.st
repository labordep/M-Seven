Class {
	#name : #MSeven3DCoordinates,
	#superclass : #Object,
	#instVars : [
		'pitch',
		'yaw',
		'roll',
		'position'
	],
	#category : #'MSeven-Model'
}

{ #category : #accessing }
MSeven3DCoordinates >> pitch [

	^ pitch ifNil:[ pitch := 0 ]
]

{ #category : #accessing }
MSeven3DCoordinates >> pitch: anObject [

	pitch := anObject
]

{ #category : #accessing }
MSeven3DCoordinates >> position [

	^ position ifNil:[ position := BlVector3D zero ]
]

{ #category : #accessing }
MSeven3DCoordinates >> position: anObject [

	position := anObject
]

{ #category : #accessing }
MSeven3DCoordinates >> roll [

	^ roll ifNil:[ roll := 0 ]
]

{ #category : #accessing }
MSeven3DCoordinates >> roll: anObject [

	roll := anObject
]

{ #category : #accessing }
MSeven3DCoordinates >> yaw [

	^ yaw ifNil:[ yaw := 0 ]
]

{ #category : #accessing }
MSeven3DCoordinates >> yaw: anObject [

	yaw := anObject
]
