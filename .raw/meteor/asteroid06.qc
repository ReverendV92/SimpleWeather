
$ambientboost
$opaque

$modelname simpleweather/meteor/asteroid_06

$include asteroid_gibs_hl2.qci

$model "Asteroid" asteroid06

$surfaceprop rock

$illumposition 0 0 0

$cdmaterials models/simpleweather/meteor

$sequence idle {
	asteroid06
	fps 1
}

$collisionmodel asteroid06_physics
{

	$mass 25000
	$inertia 0
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	// $maxconvexpieces 1

}
