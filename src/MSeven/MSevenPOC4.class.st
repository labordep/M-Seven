Class {
	#name : #MSevenPOC4,
	#superclass : #Object,
	#instVars : [
		'view',
		'space',
		'computingResolution',
		'surfaceElement',
		'worldTexture',
		'cameraPosition',
		'angle'
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
	2023-10-19 18:37:42"

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
					}
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
					}
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
					}
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
			}
		},
		#layout : @19
	}
]'
]

{ #category : #initialization }
MSevenPOC4 >> initialize [

	super initialize.
	
	computingResolution := 256@240.
	worldTexture := MSevenResources pharoTexture.
	
	self initializeView. 
	self startSurfaceElementUpdate.
	
	space := view openInNewSpaceWithPyramidShortcut.
]

{ #category : #initialization }
MSevenPOC4 >> initializeView [

	"Materialize the app view"
	view := self class view materializeAsBlElement first.
	
	"Get the surface element"
	surfaceElement := view childWithId: #texture.
	
	
]

{ #category : #initialization }
MSevenPOC4 >> startSurfaceElementUpdate [
	| transition |
	
	cameraPosition := 0@0.
	angle := 0.0.
	surfaceElement map: worldTexture cameraResolution: computingResolution.
	
	transition := BlNumberTransition new 
		from: 0; 
		to: 1; 
		onStepDo: [ :t | self transitionStep: t ]; 
		beInfinite; 
		yourself.
	
	surfaceElement enqueueTask: transition.
			
				

	
]

{ #category : #initialization }
MSevenPOC4 >> transitionStep: aNumber [

	cameraPosition := cameraPosition - (0.2 @ 0).
	angle := (cameraPosition x * 0.3) sin / 1.5.
	surfaceElement cameraPosition: cameraPosition cameraAngle: angle.
			

	
]
