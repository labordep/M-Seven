Class {
	#name : 'BaselineOfMSeven',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfMSeven',
	#package : 'BaselineOfMSeven'
}

{ #category : 'baselines' }
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

{ #category : 'baselines' }
BaselineOfMSeven >> dependencies: spec [

	"UI tool : Pyramid"
	spec baseline: 'Pyramid' with: [ spec repository: 'github://OpenSmock/Pyramid:main/src' ].
]
