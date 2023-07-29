// Created by Crowbar 0.72

$modelname "props_wasteland\rockgranite02b.mdl"

$staticprop

$bodygroup "Body"
{
	studio "rockgranite02b_reference.smd"
}


$surfaceprop "boulder"

$contents "solid"

$illumposition 4.641 0 0

$cdmaterials "models\props_wasteland\"

$texturegroup "skinfamilies"
{
	{ "rockcliff02a" }
	{ "rockcliff02b" }
	{ "dirtwall001a" }
}

$cbox 0 0 0 0 0 0

$bbox -25.791 -22.889 -43.116 25.791 32.171 43.116


$sequence "idle" {
	"rockgranite02b_anim_@idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$collisionmodel "rockgranite02b_physics.smd"
{
	$mass 50
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 1

}
