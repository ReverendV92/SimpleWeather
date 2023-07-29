// Created by Crowbar 0.72

$modelname "props_wasteland\rockgranite02a.mdl"

$staticprop

$bodygroup "Body"
{
	studio "rockgranite02a_reference.smd"
}


$surfaceprop "boulder"

$contents "solid"

$illumposition -0.932 -1.877 1.678

$cdmaterials "models\props_wasteland\"

$texturegroup "skinfamilies"
{
	{ "rockcliff02a" }
	{ "rockcliff02b" }
	{ "dirtwall001a" }
}

$cbox 0 0 0 0 0 0

$bbox -43.072 -31.567 -25.426 46.827 29.703 28.782


$sequence "idle" {
	"rockgranite02a_anim_@idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$collisionmodel "rockgranite02a_physics.smd"
{
	$mass 50
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 1

}
