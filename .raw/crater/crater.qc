
$ambientboost
$staticprop
$opaque

$modelname simpleweather/crater

$model Crater crater

$cdmaterials models/simpleweather/crater

$surfaceprop concrete
$contents solid
$illumposition 0 0 0

$sequence idle crater ACT_IDLE 1 fps 1

$collisionmodel crater
{

	$mass 25000
	$inertia 0
	$damping 0
	$rotdamping 0
	$rootbone " "
	// $concave
	$maxconvexpieces 1

}