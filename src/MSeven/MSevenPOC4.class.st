Class {
	#name : #MSevenPOC4,
	#superclass : #Object,
	#instVars : [
		'view',
		'space'
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
	2023-10-18 18:58:10"

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
							#color : Color {
								#red : 0.270772238514174,
								#green : 0.270772238514174,
								#blue : 0.270772238514174,
								#alpha : 1.0
							}
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
			BlTextElement {
				#children : BlChildrenArray [ ],
				#constraints : BlLayoutCommonConstraints {
					#vertical : BlLayoutCommonConstraintsAxis {
						#resizer : BlLayoutFitContentResizer { }
					},
					#horizontal : BlLayoutCommonConstraintsAxis {
						#resizer : @24
					},
					#position : Point [ 0.0, 0.0 ],
					#margin : @11,
					#padding : BlInsets {
						#top : 5.0,
						#left : 5.0,
						#bottom : 5.0,
						#right : 5.0
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
								#size : 15
							},
							BlTextForegroundAttribute {
								#isOverwritableByStyler : true,
								#paint : Color [ #white ]
							}
						],
						#rope : BlCollectionRope {
							#collection : ''M-Seven POC #4''
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
	
	self initializeView.
]

{ #category : #initialization }
MSevenPOC4 >> initializeView [

	view := self class view materializeAsBlElement first.
	space := view openInNewSpaceWithPyramidShortcut.
]
