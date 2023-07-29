// Created by Crowbar 0.72

$modelname "props_wasteland\rockgranite01a.mdl"

$staticprop

$bodygroup "Body"
{
	studio "rockgranite01a_reference.smd"
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

$bbox -89.243 -58.795 -43.775 89.243 58.795 43.775


$sequence "idle" {
	"rockgranite01a_anim_@idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$collisionmodel "rockgranite01a_physics.smd"
{
	$mass 200
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 1

}
