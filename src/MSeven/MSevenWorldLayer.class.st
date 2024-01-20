Class {
	#name : #MSevenWorldLayer,
	#superclass : #Object,
	#instVars : [
		'name',
		'scale',
		'sprite'
	],
	#category : #'MSeven-Model'
}

{ #category : #accessing }
MSevenWorldLayer >> name [

	^ name
]

{ #category : #accessing }
MSevenWorldLayer >> name: anObject [

	name := anObject
]

{ #category : #accessing }
MSevenWorldLayer >> scale [

	^ scale ifNil: [ scale := 1 ]
]

{ #category : #accessing }
MSevenWorldLayer >> scale: anObject [

	scale := anObject
]

{ #category : #accessing }
MSevenWorldLayer >> sprite [

	^ sprite
]

{ #category : #accessing }
MSevenWorldLayer >> sprite: anObject [

	sprite := anObject
]
