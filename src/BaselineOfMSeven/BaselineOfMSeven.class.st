Class {
	#name : #BaselineOfMSeven,
	#superclass : #BaselineOf,
	#category : #BaselineOfMSeven
}

{ #category : #baselines }
BaselineOfMSeven >> baseline: spec [
	<baseline>
	
	spec for: #common
		do: [
			"Dependencies"
			self dependencies: spec.

			"Project Packages"
			spec package: 'MSeven'.
		]
]

{ #category : #baselines }
BaselineOfMSeven >> dependencies: spec [

	"2D : Bloc"
	spec baseline: #Bloc with: [ spec repository: 'github://pharo-graphics/Bloc:dev-1.0/src' ].

	"UI : Toplo"
	spec baseline: 'Toplo' with: [ spec repository: 'github://plantec/Toplo:main/src' ].

	"UI tool : Pyramid"
	spec baseline: 'Pyramid' with: [ spec repository: 'github://OpenSmock/Pyramid:main/src' ].
]
