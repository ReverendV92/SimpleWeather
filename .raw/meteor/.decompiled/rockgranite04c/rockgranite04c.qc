// Created by Crowbar 0.72

$modelname "props_wasteland\rockgranite04c.mdl"

$staticprop

$bodygroup "Body"
{
	studio "rockgranite04c_reference.smd"
}


$surfaceprop "boulder"

$contents "solid"

$illumposition 22.033 39.242 90.778

$cdmaterials "models\props_wasteland\"

$texturegroup "skinfamilies"
{
	{ "rockcliff02a" }
	{ "rockcliff02b" }
	{ "dirtwall001a" }
}

$cbox 0 0 0 0 0 0

$bbox -370.84 -436.543 -77.791 292.357 480.608 259.347


$sequence "idle" {
	"rockgranite04c_anim_@idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$collisionmodel "rockgranite04c_physics.smd"
{
	$mass 50
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 1

}
