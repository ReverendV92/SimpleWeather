// Created by Crowbar 0.72

$modelname "props_wasteland\rockgranite04a.mdl"

$staticprop

$bodygroup "Body"
{
	studio "rockgranite04a_reference.smd"
}


$surfaceprop "boulder"

$contents "solid"

$illumposition -0.398 -3.45 4.389

$cdmaterials "models\props_wasteland\"

$texturegroup "skinfamilies"
{
	{ "rockcliff02a" }
	{ "rockcliff02b" }
	{ "dirtwall001a" }
}

$cbox 0 0 0 0 0 0

$bbox -171.303 -117.309 -87.268 178.204 116.513 96.045


$sequence "idle" {
	"rockgranite04a_anim_@idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$collisionmodel "rockgranite04a_physics.smd"
{
	$mass 50
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 1

}
