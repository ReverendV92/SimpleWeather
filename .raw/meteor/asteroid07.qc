
$ambientboost
$opaque

$modelname simpleweather/meteor/asteroid_07

$include asteroid_gibs_hl2.qci

$model "Asteroid" asteroid07

$surfaceprop rock

$illumposition 0 0 0

$cdmaterials models/simpleweather/meteor

$sequence idle {
	asteroid07
	fps 1
}

$collisionmodel asteroid07_physics
{

	$mass 25000
	$inertia 0
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	// $maxconvexpieces 1

}
