// Created by Crowbar 0.72

$modelname "props_wasteland\rockgranite01c.mdl"

$staticprop

$bodygroup "Body"
{
	studio "rockgranite01c_reference.smd"
}


$surfaceprop "boulder"

$contents "solid"

$illumposition 4.943 9.343 20.76

$cdmaterials "models\props_wasteland\"

$texturegroup "skinfamilies"
{
	{ "rockcliff02a" }
	{ "rockcliff02b" }
	{ "dirtwall001a" }
}

$cbox 0 0 0 0 0 0

$bbox -88.51 -104.153 -18.736 69.823 114.04 60.256


$sequence "idle" {
	"rockgranite01c_anim_@idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$collisionmodel "rockgranite01c_physics.smd"
{
	$mass 200
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 1

}
