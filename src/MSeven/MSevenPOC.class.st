Class {
	#name : #MSevenPOC,
	#superclass : #Object,
	#category : #'MSeven-POC'
}

{ #category : #'pyramid-serialized-bloc' }
MSevenPOC class >> start [
	<script>
	
	self new.
]

{ #category : #'pyramid-serialized-bloc' }
MSevenPOC class >> testView [
	"This class has been generated using Pyramid.

	By: labordep
	2023-10-09 21:07:37"
	<pySTON>
	^ '[
	BlElement {
		#children : BlChildrenArray [ ],
		#constraints : BlLayoutCommonConstraints {
			#vertical : BlLayoutCommonConstraintsAxis {
				#resizer : BlLayoutMatchParentResizer { }
			},
			#horizontal : BlLayoutCommonConstraintsAxis {
				#resizer : @6
			},
			#position : Point [ 0.0, 0.0 ],
			#margin : BlInsets {
				#top : 0.0,
				#left : 0.0,
				#bottom : 0.0,
				#right : 0.0
			},
			#padding : @9,
			#minHeight : 0.0,
			#minWidth : 0.0,
			#maxHeight : Float [ #infinity ],
			#maxWidth : @10,
			#ignoredByLayout : false,
			#accountTransformation : false
		},
		#visuals : BlCustomVisuals {
			#background : BlPaintBackground {
				#paint : BlColorPaint {
					#color : Color {
						#red : 0.6920821114369502,
						#green : 0.4359726295210166,
						#blue : 0.24926686217008798,
						#alpha : 1.0
					}
				}
			}
		},
		#userData : IdentityDictionary {
			#elementId : BlElementNamedId {
				#identifier : #Map
			}
		},
		#layout : BlFlowLayout {
			#measurer : BlFlowLayoutMeasurer {
				#layout : @17,
				#children : OrderedCollection [ ],
				#lines : OrderedCollection [
					BlFlowLayoutLine {
						#children : OrderedCollection [ ],
						#startLength : 0,
						#startBreadth : 0,
						#length : 0,
						#breadth : 0,
						#measurer : @18
					}
				],
				#orientation : BlFlowLayoutHorizontal { },
				#maxWidth : 800.0,
				#maxHeight : 600.0,
				#widthMode : BlMeasurementSpec {
					#size : 800.0,
					#mode : BlMeasurementExactMode { }
				},
				#heightMode : BlMeasurementSpec {
					#size : 600.0,
					#mode : @25
				},
				#checkCanFit : true
			},
			#orientation : BlLayoutHorizontal { },
			#horizontalAlignment : BlHorizontalStartAlignment { },
			#verticalAlignment : BlTopAlignment { }
		},
		#eventDispatcher : BlElementEventDispatcher {
			#owner : @2,
			#handlers : [
				
			]
		}
	}
]'
]

{ #category : #private }
MSevenPOC >> applyMode7Transform: aForm [
	| screenResolution halfWidth halfHeight focalLens scale textureSize floor screen width height |

	screenResolution := 240@160.
	width := screenResolution x.
	height := screenResolution y.
	halfWidth := (screenResolution x / 2) asInteger.
	halfHeight := (screenResolution y / 2) asInteger.
	focalLens := 250.
	scale := 100.
	
	floor := aForm.
	textureSize := floor width @ floor height. 
	screen := (Form extent: screenResolution depth: 32) fillBlack.
	"screen colors: (Array with: Color yellow)."
	
	"iterating over the screen array"
	1 to: width do:[ :i | 
		halfHeight to: height do:[ :j | | x y z px py floorPos floorColor attenuation |
			"x y z"
			x := halfWidth - i.
			y := j + focalLens.
			z := j - halfHeight + 0.01.
			
			"projection"
			px := x / z * scale.
			py := y / z * scale.
			
			"floor pixel pos and color"
			floorPos := ((px \\ (textureSize x)) asInteger) @ ((py \\ (textureSize y)) asInteger). 
			floorColor := floor colorAt: floorPos.
			
			"shading & fog"
			attenuation := (1.5 * ((z abs) / halfHeight)) max: 0; min: 1.
			floorColor := floorColor adjustBrightness: ((1 - (attenuation)) negated).
			
			"fill screen"
			screen colorAt: (i@j) put: floorColor.
			screen colorAt: (i@(height - j)) put: floorColor.
		].
	].
	
	^ screen
	
]

{ #category : #initialization }
MSevenPOC >> initialize [ 
	
	| view |
	super initialize.
	
	view := self class testView materializeAsBlElement.
	
	self loadImage: (ImageReadWriter formFromFileNamed: 'map3.png') in: view first.
		
	view first openInNewSpaceWithPyramidShortcut.
]

{ #category : #private }
MSevenPOC >> loadImage: anImage in: aBlElement [

	| background image |
	
	"Transform image as Mode7"
	image := self applyMode7Transform: anImage.
	
	"Apply to a background"
	background := BlImageBackground image: image. 
	
	aBlElement background: background.
]
