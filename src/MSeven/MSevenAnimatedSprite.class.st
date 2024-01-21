Class {
	#name : #MSevenAnimatedSprite,
	#superclass : #MSevenSprite,
	#instVars : [
		'formList',
		'currentStep',
		'lastCallTime',
		'stepDuration'
	],
	#category : #'MSeven-Model'
}

{ #category : #texture }
MSevenAnimatedSprite >> addTexture: aForm [

	self formList add: aForm
]

{ #category : #accessing }
MSevenAnimatedSprite >> extent [

	^ extent ifNil:[ extent := self formList first extent ]
]

{ #category : #accessing }
MSevenAnimatedSprite >> formList [

	^ formList ifNil:[ formList := OrderedCollection new: 5 ]
]

{ #category : #accessing }
MSevenAnimatedSprite >> formList: anObject [

	formList := anObject
]

{ #category : #private }
MSevenAnimatedSprite >> initialize [ 

	super initialize.
	currentStep := 0.
]

{ #category : #accessing }
MSevenAnimatedSprite >> lastCallTime [

	^ lastCallTime
]

{ #category : #accessing }
MSevenAnimatedSprite >> lastCallTime: anObject [

	lastCallTime := anObject
]

{ #category : #private }
MSevenAnimatedSprite >> nextTexture [
	"change texture to display at each call"
	
	currentStep := currentStep + 1.
	currentStep > self formList size ifTrue:[ currentStep := 1	].
	
	self texture: (self formList at: currentStep).
]

{ #category : #accessing }
MSevenAnimatedSprite >> stepDuration [

	^ stepDuration ifNil: [ stepDuration := 1 second ]
]

{ #category : #accessing }
MSevenAnimatedSprite >> stepDuration: anObject [

	stepDuration := anObject
]

{ #category : #accessing }
MSevenAnimatedSprite >> textureToDisplay [

	| now |
	now := Time now.
	(self lastCallTime isNil or:[(Time now asDuration > (self lastCallTime asDuration + self stepDuration))]) ifTrue:[
		self nextTexture.
		self lastCallTime: now.
	].
	
	^ super textureToDisplay
]
