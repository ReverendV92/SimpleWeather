
$ambientboost
$opaque

$modelname simpleweather/meteor/asteroid_02

$include asteroid_gibs_hl2.qci

$model "Asteroid" asteroid02

$surfaceprop rock

$illumposition 0 0 0

$cdmaterials models/simpleweather/meteor

$sequence idle {
	asteroid02
	fps 1
}

$collisionmodel asteroid02_physics
{

	$mass 25000
	$inertia 0
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	// $maxconvexpieces 1

}
