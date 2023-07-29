// Created by Crowbar 0.72

$modelname "props_wasteland\rockgranite01b.mdl"

$staticprop

$bodygroup "Body"
{
	studio "rockgranite01b_reference.smd"
}


$surfaceprop "boulder"

$contents "solid"

$illumposition 6.023 0 0

$cdmaterials "models\props_wasteland\"

$texturegroup "skinfamilies"
{
	{ "rockcliff02a" }
	{ "rockcliff02b" }
	{ "dirtwall001a" }
}

$cbox 0 0 0 0 0 0

$bbox -79.873 -49.22 -55.225 79.873 61.267 55.225


$sequence "idle" {
	"rockgranite01b_anim_@idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$collisionmodel "rockgranite01b_physics.smd"
{
	$mass 200
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 1

}
