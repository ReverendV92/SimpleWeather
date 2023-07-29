// Created by Crowbar 0.72

$modelname "props_wasteland\rockgranite03a.mdl"

$staticprop

$bodygroup "Body"
{
	studio "rockgranite03a_reference.smd"
}


$surfaceprop "boulder"

$contents "solid"

$illumposition -0.421 1.663 -1.034

$cdmaterials "models\props_wasteland\"

$texturegroup "skinfamilies"
{
	{ "rockcliff02a" }
	{ "rockcliff02b" }
	{ "dirtwall001a" }
}

$cbox 0 0 0 0 0 0

$bbox -19.025 -17.743 -24.168 15.699 16.901 22.1


$sequence "idle" {
	"rockgranite03a_anim_@idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$collisionmodel "rockgranite03a_physics.smd"
{
	$mass 50
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 1

}
