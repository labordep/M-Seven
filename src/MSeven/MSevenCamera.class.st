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

	^ coordinates ifNil:[ coordinates := MSevenCoordinates new ]
]

{ #category : #accessing }
MSevenCamera >> coordinates: aMSevenCoordinates [

	coordinates := aMSevenCoordinates
]

{ #category : #accessing }
MSevenCamera >> fieldOfView [

	^ fieldOfView ifNil:[ fieldOfView := 0 ]
]

{ #category : #accessing }
MSevenCamera >> fieldOfView: anObject [

	fieldOfView := anObject
]

{ #category : #initialization }
MSevenCamera >> initialize [ 

	super initialize.
	self coordinates: MSevenCoordinates new.
]
