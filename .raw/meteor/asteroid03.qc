
$ambientboost
$opaque

$modelname simpleweather/meteor/asteroid_03

$include asteroid_gibs_hl2.qci

$model "Asteroid" asteroid03

$surfaceprop rock

$illumposition 0 0 0

$cdmaterials models/simpleweather/meteor

$sequence idle {
	asteroid03
	fps 1
}

$collisionmodel asteroid03_physics
{

	$mass 25000
	$inertia 0
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	// $maxconvexpieces 1

}
