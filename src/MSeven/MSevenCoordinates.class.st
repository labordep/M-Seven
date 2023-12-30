Class {
	#name : #MSevenCoordinates,
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
MSevenCoordinates >> pitch [

	^ pitch ifNil:[ pitch := 0 ]
]

{ #category : #accessing }
MSevenCoordinates >> pitch: anObject [

	pitch := anObject
]

{ #category : #accessing }
MSevenCoordinates >> position [

	^ position ifNil:[ position := BlVector3D zero ]
]

{ #category : #accessing }
MSevenCoordinates >> position: anObject [

	position := anObject
]

{ #category : #accessing }
MSevenCoordinates >> roll [

	^ roll ifNil:[ roll := 0 ]
]

{ #category : #accessing }
MSevenCoordinates >> roll: anObject [

	roll := anObject
]

{ #category : #accessing }
MSevenCoordinates >> yaw [

	^ yaw ifNil:[ yaw := 0 ]
]

{ #category : #accessing }
MSevenCoordinates >> yaw: anObject [

	yaw := anObject
]
