Class {
	#name : #MSevenPOC4,
	#superclass : #Object,
	#instVars : [
		'view',
		'space',
		'surfaceElement',
		'worldTexture',
		'cameraPosition',
		'cameraAltitude',
		'cameraAngle',
		'cameraSpeed',
		'isArrowUpPressed',
		'isArrowDownPressed',
		'isAltitudeDownPressed',
		'isAltitudeUpPressed',
		'isLeftPressed',
		'isRightPressed',
		'isArrowLeftPressed',
		'isArrowRightPressed',
		'worldResolution'
	],
	#category : #'MSeven-POC'
}

{ #category : #accessing }
MSevenPOC4 class >> start [
	<script>
	
	self new.
]

{ #category : #'pyramid-serialized-bloc' }
MSevenPOC4 class >> view [
	"This class has been generated using Pyramid.

	By: labordep
	2023-10-21 14:03:17"

	<pySTON>
	^ '[
	BlElement {
		#children : BlChildrenArray [
			BlElement {
				#children : BlChildrenArray [ ],
				#constraints : BlLayoutCommonConstraints {
					#vertical : BlLayoutCommonConstraintsAxis {
						#resizer : BlLayoutMatchParentResizer { }
					},
					#horizontal : BlLayoutCommonConstraintsAxis {
						#resizer : @8
					},
					#position : Point [ 0.0, 0.0 ],
					#margin : BlInsets {
						#top : 0.0,
						#left : 0.0,
						#bottom : 0.0,
						#right : 0.0
					},
					#padding : @11,
					#minHeight : 0.0,
					#minWidth : 0.0,
					#maxHeight : Float [ #infinity ],
					#maxWidth : @12,
					#ignoredByLayout : false,
					#accountTransformation : false
				},
				#visuals : BlCustomVisuals {
					#background : BlPaintBackground {
						#paint : BlColorPaint {
							#color : Color [ #white ]
						}
					}
				},
				#userData : IdentityDictionary {
					#elementId : BlElementNamedId {
						#identifier : #background
					},
					#shouldHandleMousePickOutsideEvent : false
				},
				#layout : BlBasicLayout { }
			},
			MSevenAeSurfaceBlElement4 {
				#children : BlChildrenArray [ ],
				#constraints : BlLayoutCommonConstraints {
					#vertical : BlLayoutCommonConstraintsAxis {
						#resizer : BlLayoutMatchParentResizer { }
					},
					#horizontal : BlLayoutCommonConstraintsAxis {
						#resizer : @24
					},
					#position : Point [ 0.0, 0.0 ],
					#margin : BlInsets {
						#top : 0.0,
						#left : 0.0,
						#bottom : 0.0,
						#right : 0.0
					},
					#padding : @27,
					#minHeight : 0.0,
					#minWidth : 0.0,
					#maxHeight : @12,
					#maxWidth : @12,
					#ignoredByLayout : false,
					#accountTransformation : false
				},
				#visuals : BlDefaultVisuals { },
				#userData : IdentityDictionary {
					#elementId : BlElementNamedId {
						#identifier : #texture
					},
					#shouldHandleMousePickOutsideEvent : false
				},
				#layout : BlBasicLayout { }
			},
			BlTextElement {
				#children : BlChildrenArray [ ],
				#constraints : BlLayoutCommonConstraints {
					#vertical : BlLayoutCommonConstraintsAxis {
						#resizer : BlLayoutFitContentResizer { }
					},
					#horizontal : BlLayoutCommonConstraintsAxis {
						#resizer : @36
					},
					#position : Point [ 0, 0 ],
					#margin : @11,
					#padding : BlInsets {
						#top : 20.0,
						#left : 20.0,
						#bottom : 20.0,
						#right : 20.0
					},
					#minHeight : 0.0,
					#minWidth : 0.0,
					#maxHeight : @12,
					#maxWidth : @12,
					#ignoredByLayout : false,
					#accountTransformation : false
				},
				#visuals : BlCustomVisuals {
					#background : BlTransparentBackground {
						
					}
				},
				#userData : IdentityDictionary {
					#elementId : BlElementNamedId {
						#identifier : #title
					},
					#shouldHandleMousePickOutsideEvent : false
				},
				#layout : @19,
				#text : BlRopedText {
					#rope : BlAttributeRope {
						#attributes : [
							BlFontSizeAttribute {
								#isOverwritableByStyler : true,
								#size : 20
							},
							BlTextForegroundAttribute {
								#isOverwritableByStyler : true,
								#paint : Color {
									#red : 0.7487781036168133,
									#green : 0.0,
									#blue : 1.0,
									#alpha : 1.0
								}
							}
						],
						#rope : BlCollectionRope {
							#collection : ''M-Seven Proof Of Concept #4''
						}
					}
				}
			},
			BlTextElement {
				#children : BlChildrenArray [ ],
				#constraints : BlLayoutCommonConstraints {
					#vertical : BlLayoutCommonConstraintsAxis {
						#resizer : BlLayoutFitContentResizer { }
					},
					#horizontal : BlLayoutCommonConstraintsAxis {
						#resizer : @55
					},
					#position : Point [ 19.0, 43.0 ],
					#margin : BlInsets {
						#top : 0.0,
						#left : 0.0,
						#bottom : 0.0,
						#right : 0.0
					},
					#padding : @58,
					#minHeight : 0.0,
					#minWidth : 0.0,
					#maxHeight : @12,
					#maxWidth : @12,
					#ignoredByLayout : false,
					#accountTransformation : false
				},
				#visuals : BlDefaultVisuals { },
				#userData : IdentityDictionary {
					#elementId : BlElementNamedId {
						#identifier : #instructions
					},
					#shouldHandleMousePickOutsideEvent : false
				},
				#layout : BlBasicLayout { },
				#text : BlRopedText {
					#rope : BlCollectionRope {
						#collection : ''To translate: ZQSD / WASD, to turn: Left/Right arrow, to -/+ alt : R/T''
					}
				}
			}
		],
		#constraints : BlLayoutCommonConstraints {
			#vertical : BlLayoutCommonConstraintsAxis {
				#resizer : @8
			},
			#horizontal : BlLayoutCommonConstraintsAxis {
				#resizer : @8
			},
			#position : Point [ 0.0, 0.0 ],
			#margin : @11,
			#padding : @11,
			#minHeight : 0.0,
			#minWidth : 0.0,
			#maxHeight : @12,
			#maxWidth : @12,
			#ignoredByLayout : false,
			#accountTransformation : false
		},
		#visuals : BlCustomVisuals {
			#clipChildren : false
		},
		#userData : IdentityDictionary {
			#elementId : BlElementNamedId {
				#identifier : #pane
			},
			#shouldHandleMousePickOutsideEvent : false
		},
		#layout : @19
	}
]'
]

{ #category : #private }
MSevenPOC4 >> computeWorldResolution [
	"Compute the world resolution to have correct ratio depending size of the application window to be in fullsize"

	"resolution for ratio 4/3"
	| windowSize ratio defaultWindowSize newWidth newResolution newHeight |
	worldResolution := 256@192.
	defaultWindowSize := 400@300.
	
	"get actual window size"
	windowSize := space ifNil:[ defaultWindowSize ] ifNotNil:[ :s | s windowExtent ].
	(windowSize x = 0 or:[ windowSize y = 0 ]) ifTrue:[windowSize := defaultWindowSize].
	
	"compute balance between preserving world resoltuion ratio and pixels size"
	ratio := windowSize x / windowSize y.
	ratio >= 1 ifTrue:[ 
		"more larger than heighter" 
		newWidth := windowSize x * worldResolution y / windowSize y.
		newResolution := newWidth @ worldResolution y.
	] ifFalse:[
		"more heighter than larger"
		newHeight := windowSize y * worldResolution x / windowSize x.
		newResolution := worldResolution x @ newHeight.
	].

	worldResolution := newResolution rounded.
]

{ #category : #initialization }
MSevenPOC4 >> initialize [

	super initialize.
	self computeWorldResolution.

	worldTexture := MSevenResources ground_pharo_step3.
	cameraPosition := 0 @ 0.
	cameraAltitude := 1.0.
	cameraAngle := 0.
	cameraSpeed := 0.1.

	isArrowUpPressed := false.
	isArrowDownPressed := false.
	isLeftPressed := false.
	isRightPressed := false.
	isAltitudeDownPressed := false.
	isAltitudeUpPressed := false.
	isArrowLeftPressed := false.
	isArrowRightPressed := false.

	self initializeView.
	self startSurfaceElementUpdate.

	space := view openInNewSpace.

	"Install events listener"
	space addEventHandler: (BlEventHandler
			 on: BlKeyDownEvent
			 do: [ :e | self processKeyDownEvent: e ]).
	space addEventHandler: (BlEventHandler
			 on: BlKeyUpEvent
			 do: [ :e | self processKeyUpEvent: e ]).
	space addEventHandler: (BlEventHandler
			 on: BlSpaceResizedEvent
			 do: [ :e |
				 self computeWorldResolution.
				 self updateSurfaceElementUpdate ])
]

{ #category : #ui }
MSevenPOC4 >> initializeToploUI [

	"Set UI Theme"
	| fullScreenButton |
	fullScreenButton := (ToButton id: #fullscreenButton) labelText: 'Fullscreen'; position: 300@10.
	fullScreenButton addStamp: #primary.
	fullScreenButton whenClickedDo: [ self toggleFullscreen ].	
	view addChild: fullScreenButton.
]

{ #category : #ui }
MSevenPOC4 >> initializeView [

	"Materialize the app view"
	view := self class view materializeAsBlElement first.
	
	self initializeToploUI.
	
	"Get the surface element"
	surfaceElement := view childWithId: #texture.
	
	
]

{ #category : #listeners }
MSevenPOC4 >> processKeyDownEvent: anEvent [

	"Set the key down state for movement keys"
	"Arrow or ZQSD/WASD for azerty/qwerty keyboard"

	(anEvent key isArrowUp or:[anEvent key = (KeyboardKey Z) or:[anEvent key = (KeyboardKey W)]]) ifTrue:[
		isArrowUpPressed := true.
		^ self
	].

	(anEvent key isArrowDown or:[anEvent key = (KeyboardKey S)]) ifTrue:[
		isArrowDownPressed := true.
		^self	
	].

	(anEvent key = (KeyboardKey Q) or:[anEvent key = (KeyboardKey A)]) ifTrue:[
		isLeftPressed := true. 
		^self	
	].

	(anEvent key = (KeyboardKey D)) ifTrue:[
		isRightPressed := true.
		^self	
	].

	"Altitude management : R/T"
	anEvent key = (KeyboardKey R) ifTrue:[
		isAltitudeDownPressed := true.
		^self	
	]. 

	anEvent key = (KeyboardKey T) ifTrue:[
		isAltitudeUpPressed := true.
		^self	
	].
	
	"Angle management : LEFT / RIGHT arrows" 
	anEvent key isArrowLeft ifTrue:[
		isArrowLeftPressed := true.
		^self	
	].

	anEvent key isArrowRight ifTrue:[
		isArrowRightPressed := true.
		^self	
	].
	
]

{ #category : #listeners }
MSevenPOC4 >> processKeyUpEvent: anEvent [

	"Set the key up state for movement keys"
	"Arrow or ZQSD/WASD for azerty/qwerty keyboard"

	(anEvent key isArrowUp or:[anEvent key = (KeyboardKey Z) or:[anEvent key = (KeyboardKey W)]]) ifTrue:[
		isArrowUpPressed := false.
		^ self
	].

	(anEvent key isArrowDown or:[anEvent key = (KeyboardKey S)]) ifTrue:[
		isArrowDownPressed := false.
		^self	
	].

	(anEvent key = (KeyboardKey Q) or:[anEvent key = (KeyboardKey A)]) ifTrue:[
		isLeftPressed := false. 
		^self	
	].

	(anEvent key = (KeyboardKey D)) ifTrue:[
		isRightPressed := false.
		^self	
	].

	"Altitude management : R/T"
	anEvent key = (KeyboardKey R) ifTrue:[
		isAltitudeDownPressed := false.
		^self	
	]. 

	anEvent key = (KeyboardKey T) ifTrue:[
		isAltitudeUpPressed := false.
		^self	
	].
	
	"Angle management : LEFT / RIGHT arrows" 
	anEvent key isArrowLeft ifTrue:[
		isArrowLeftPressed := false.
		^self	
	].

	anEvent key isArrowRight ifTrue:[
		isArrowRightPressed := false.
		^self	
	].
]

{ #category : #initialization }
MSevenPOC4 >> startSurfaceElementUpdate [
	| transition |
	
	surfaceElement map: worldTexture cameraResolution: worldResolution.
	
	transition := BlNumberTransition new 
		from: 0; 
		to: 1; 
		onStepDo: [ :t | 
			self updateMovementStep: t.
			self updateSurfaceStep: t 
		]; 
		beInfinite; 
		yourself.
	
	surfaceElement enqueueTask: transition.
			
				

	
]

{ #category : #actions }
MSevenPOC4 >> toggleFullscreen [

	space ifNil:[ ^ self ].
	space fullscreen: (space fullscreen not).
]

{ #category : #private }
MSevenPOC4 >> updateMovementStep: aNumber [
	"Compute movement depending down/up keys"
	
	| sin cos dx dy speedCos speedSin |
	sin := cameraAngle sin.
	cos := cameraAngle cos.
	dx := 0. dy := 0.
	speedSin := cameraSpeed * sin.
	speedCos := cameraSpeed * cos.
	
	isArrowUpPressed ifTrue:[ dx := dx - speedCos. dy := dy - speedSin ].
	isArrowDownPressed ifTrue:[ dx := dx + speedCos. dy := dy + speedSin ].
	isLeftPressed ifTrue:[ dx := dx - speedSin. dy := dy + speedCos ].
	isRightPressed ifTrue:[ dx := dx + speedSin. dy := dy - speedCos ].
	
	cameraPosition := cameraPosition + (dx @ dy).
	
	isArrowLeftPressed ifTrue:[ cameraAngle := cameraAngle - (cameraSpeed / 3) ].
	isArrowRightPressed ifTrue:[ cameraAngle := cameraAngle + (cameraSpeed / 3) ].
	
	isAltitudeUpPressed ifTrue:[ cameraAltitude := cameraAltitude + (cameraSpeed * 10) ].
	isAltitudeDownPressed ifTrue:[ cameraAltitude := cameraAltitude - (cameraSpeed * 10) ].
	
	cameraAltitude := (cameraAltitude max: 0.001) min: 100.0.
]

{ #category : #initialization }
MSevenPOC4 >> updateSurfaceElementUpdate [
	"Call this method to change the computing resolution after an application window resize"
	
	surfaceElement cameraResolution: worldResolution
]

{ #category : #private }
MSevenPOC4 >> updateSurfaceStep: aNumber [
	
	"Update surface"
	surfaceElement cameraPosition: cameraPosition cameraAltitude: cameraAltitude cameraAngle: cameraAngle
			

	
]
