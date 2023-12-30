Class {
	#name : #MSevenCamera,
	#superclass : #Object,
	#instVars : [
		'coordinates',
		'fieldOfView'
	],
	#category : #'MSeven-Model'
}

{ #category : #accessing }
MSevenCamera >> coordinates [

	^ coordinates ifNil:[ coordinates := MSeven3DCoordinates new ]
]

{ #category : #accessing }
MSevenCamera >> coordinates: anObject [

	coordinates := anObject
]

{ #category : #accessing }
MSevenCamera >> fieldOfView [

	^ fieldOfView ifNil:[ fieldOfView := 0 ]
]

{ #category : #accessing }
MSevenCamera >> fieldOfView: anObject [

	fieldOfView := anObject
]
