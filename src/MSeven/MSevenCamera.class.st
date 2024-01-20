Class {
	#name : #MSevenCamera,
	#superclass : #Object,
	#instVars : [
		'fieldOfView',
		'pose'
	],
	#category : #'MSeven-Model'
}

{ #category : #accessing }
MSevenCamera >> fieldOfView [

	^ fieldOfView ifNil:[ fieldOfView := 0 ]
]

{ #category : #accessing }
MSevenCamera >> fieldOfView: anObject [

	fieldOfView := anObject
]

{ #category : #accessing }
MSevenCamera >> pose [

	^ pose ifNil:[ pose := MSevenPose new ]
]

{ #category : #accessing }
MSevenCamera >> pose: aMSevenPose [

	pose := aMSevenPose
]
