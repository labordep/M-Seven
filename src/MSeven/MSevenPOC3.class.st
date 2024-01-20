Class {
	#name : #MSevenPOC3,
	#superclass : #Object,
	#instVars : [
		'map',
		'viewResolution',
		'viewSurface'
	],
	#category : #'MSeven-POC'
}

{ #category : #accessing }
MSevenPOC3 class >> start [
	<script>
	
	self new.
]

{ #category : #'pyramid-serialized-bloc' }
MSevenPOC3 class >> view [
	"This class has been generated using Pyramid.

	By: labordep
	2023-10-12 23:47:28"

	<pySTON>
	^ '[
	MSevenAeSurfaceBlElement3 {
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
			#background : BlTransparentBackground {
				
			}
		},
		#userData : IdentityDictionary {
			#elementId : BlElementNamedId {
				#identifier : #Map
			}
		},
		#layout : BlFlowLayout {
			#measurer : BlFlowLayoutMeasurer {
				#layout : @15,
				#children : OrderedCollection [ ],
				#lines : OrderedCollection [
					BlFlowLayoutLine {
						#children : OrderedCollection [ ],
						#startLength : 0,
						#startBreadth : 0,
						#length : 0,
						#breadth : 0,
						#measurer : @16
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
					#mode : @23
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

{ #category : #initialization }
MSevenPOC3 >> initialize [

	| view space position angle |
	super initialize.

	viewResolution := 256 @ 240.
	view := self class view materializeAsBlElement first.
	view
		map: MSevenResources ground_checkerboard
		cameraResolution: viewResolution.

	space := view openInNewSpace.
	space extent: viewResolution.

	position := 0@0.
	view enqueueTask:
		(BlNumberTransition new
			from: 0; to: 1;
			onStepDo: [ :t |
				position := position + (0.01 @ 0).
				angle := (position x * 0.3) sin.
				view
					cameraPosition: position
					cameraAngle: angle ];
			beInfinite;
			yourself)
]
