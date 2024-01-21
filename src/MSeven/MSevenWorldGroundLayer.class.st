Class {
	#name : #MSevenWorldGroundLayer,
	#superclass : #MSevenWorldLayer,
	#instVars : [
		'scale'
	],
	#category : #'MSeven-Model'
}

{ #category : #testing }
MSevenWorldGroundLayer >> isGround [

	^ true
]

{ #category : #accessing }
MSevenWorldGroundLayer >> scale [
	"define the size of meters per pixels"
	
	^ scale ifNil: [ scale := 1 ]
]

{ #category : #accessing }
MSevenWorldGroundLayer >> scale: anObject [

	scale := anObject
]
