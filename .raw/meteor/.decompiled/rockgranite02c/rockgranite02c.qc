// Created by Crowbar 0.72

$modelname "props_wasteland\rockgranite02c.mdl"

$staticprop

$bodygroup "Body"
{
	studio "rockgranite02c_reference.smd"
}


$surfaceprop "boulder"

$contents "solid"

$illumposition 4.05 0 -0.37

$cdmaterials "models\props_wasteland\"

$texturegroup "skinfamilies"
{
	{ "rockcliff02a" }
	{ "rockcliff02b" }
	{ "dirtwall001a" }
}

$cbox 0 0 0 0 0 0

$bbox -34.423 -41.337 -22.578 34.423 49.437 21.838


$sequence "idle" {
	"rockgranite02c_anim_@idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$collisionmodel "rockgranite02c_physics.smd"
{
	$mass 50
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 1

}
