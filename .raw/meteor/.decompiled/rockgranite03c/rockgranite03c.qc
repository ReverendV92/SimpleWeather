// Created by Crowbar 0.72

$modelname "props_wasteland\rockgranite03c.mdl"

$staticprop

$bodygroup "Body"
{
	studio "rockgranite03c_reference.smd"
}


$surfaceprop "boulder"

$contents "solid"

$illumposition 0 0 0

$cdmaterials "models\props_wasteland\"

$texturegroup "skinfamilies"
{
	{ "rockcliff02a" }
	{ "rockcliff02b" }
	{ "dirtwall001a" }
}

$cbox 0 0 0 0 0 0

$bbox -29.336 -17.64 -9.543 29.336 17.64 9.543


$sequence "idle" {
	"rockgranite03c_anim_@idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$collisionmodel "rockgranite03c_physics.smd"
{
	$mass 50
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 1

}
