Extension { #name : #BlPoint3D }

{ #category : #'*MSeven' }
BlPoint3D >> + aBlPoint3D [ 

	^ self class x: (self x + aBlPoint3D x) y: (self y + aBlPoint3D y) z: (self z + aBlPoint3D z)
]

{ #category : #'*MSeven' }
BlPoint3D >> - aBlPoint3D [

	^ self class x: (self x - aBlPoint3D x) y: (self y - aBlPoint3D y) z: (self z - aBlPoint3D z)
]

{ #category : #'*MSeven' }
BlPoint3D >> abs [
	
	^ self class x: (self x abs) y: (self y abs) z: (self z abs)
]
