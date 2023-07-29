// Created by Crowbar 0.72

$modelname "props_wasteland\rockgranite04b.mdl"

$staticprop

$bodygroup "Body"
{
	studio "rockgranite04b_reference.smd"
}


$surfaceprop "boulder"

$contents "solid"

$illumposition 14.182 0.901 2.142

$cdmaterials "models\props_wasteland\"

$texturegroup "skinfamilies"
{
	{ "rockcliff02a" }
	{ "rockcliff02b" }
	{ "dirtwall001a" }
}

$cbox 0 0 0 0 0 0

$bbox -160.226 -98.16 -110.169 159.466 122.402 114.172


$sequence "idle" {
	"rockgranite04b_anim_@idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$collisionmodel "rockgranite04b_physics.smd"
{
	$mass 50
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 7

}
